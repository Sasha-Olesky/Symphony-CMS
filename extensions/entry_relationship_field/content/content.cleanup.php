<?php
	/*
	Copyight: Deux Huit Huit 2017
	License: MIT, http://deuxhuithuit.mit-license.org
	*/

	if(!defined("__IN_SYMPHONY__")) die("<h2>Error</h2><p>You cannot directly access this file</p>");

	require_once(EXTENSIONS . '/entry_relationship_field/lib/class.cacheablefetch.php');

	class contentExtensionEntry_Relationship_FieldCleanup extends AdministrationPage
	{
		private $sectionManager;
		private $fieldManager;
		private $entryManager;
		
		public function __construct()
		{
			parent::__construct();
			$this->sectionManager = new CacheableFetch('SectionManager');
			$this->fieldManager = new CacheableFetch('FieldManager');
			$this->entryManager = new CacheableFetch('EntryManager');
		}
		
		private static function TableLabel($value)
		{
			$label = new XMLElement('span', __($value), array('class' => 'inactive'));
			return $label->generate() . '<br />';
		}
		
		/**
		 *
		 * Builds the content view
		 */
		public function __viewIndex()
		{
			$title = __('Entry Relationship Clean up');
			
			$this->setTitle(__('%1$s &ndash; %2$s', array(__('Symphony'), $title)));
			$this->addScriptToHead(URL . '/extensions/entry_relationship_field/assets/cleanup.entry_relationship_field.js', 10, false);
			$this->setPageType('table');
			$this->appendSubheading(__($title));
			
			$fieldset = new XMLElement('fieldset', null, array('class' => 'settings'));
			
			$fieldset->appendChild(new XMLElement('legend',__('List of all orphans entries')));
			$fieldset->appendChild(new XMLElement('p',__('Please choose what to delete', array('class' => 'help'))));
			
			$this->Form->appendChild($fieldset);
			
			$fields = $this->getAllFieldsData();
			$sections = $this->normalizeDataPerSection($fields);
			
			$thead = array(
				self::TableLabel('Section'),
				self::TableLabel('Fields linked to'),
				self::TableLabel('Number of entries'),
				self::TableLabel('Orphan entries'),
				self::TableLabel('Linked entries'),
			);
			$tbody = array();

			// If there are no fields, display default message
			if (!is_array($sections) || empty($sections)) {
				$tbody[] = Widget::TableRow(array(
					Widget::TableData(
						__('No data available.'),
						'inactive',
						null,
						count($thead)
					))
				);
			}

			// Otherwise, build table rows
			else {
				foreach ($sections as $section) {
					if (empty($section['orphans'])) {
						continue;
					}
					$tbody[] = Widget::TableRow(array(
						Widget::TableData(
							Widget::Anchor('#',
								'#' . $section['section']->get('handle'), null, null,
								$section['section']->get('handle')
							)->generate() . ' ' . $thead[0] .
							Widget::Anchor(
								$section['section']->get('name'),
								SYMPHONY_URL . '/publish/' . $section['section']->get('handle') . '/'
							)->generate()
						),
						Widget::TableData($thead[1] . count($section['fields']) . $this->generateFieldsLink($section)),
						Widget::TableData($thead[2] . count($section['all-entries'])),
						Widget::TableData($thead[3] . count($section['orphans'])),
						Widget::TableData($thead[4] . count($section['linked-entries'])),
					), 'js-table-section');
					$tbody[] = Widget::TableRow(array(
						Widget::TableData(
							$this->generateOrphanTable($section),
							null, null, count($thead)
						),
					), 'js-table-entries irrelevant');
				}
			}
			$table = Widget::Table(
				null, null,
				Widget::TableBody($tbody), '', null,
				array('role' => 'directory', 'aria-labelledby' => 'symphony-subheading', 'data-interactive' => 'data-interactive')
			);
			$this->Form->appendChild($table);

			if (is_array($sections) && !empty($sections)) {
				// Append table actions
				$options = array(
					array(null, false, __('With Selected...')),
					array('delete', false, __('Delete'), 'confirm', null, array(
						'data-message' => __('Are you sure you want to delete the selected entries?')
					))
				);

				$tableActions = new XMLElement('div');
				$tableActions->setAttribute('class', 'actions');
				$tableActions->appendChild(Widget::Apply($options));
				$this->Form->appendChild($tableActions);
			}
		}


		public function __actionIndex()
		{
			$checked = (is_array($_POST['items'])) ? array_keys($_POST['items']) : null;

			if (is_array($checked) && !empty($checked)) {
				switch ($_POST['with-selected']) {
					case 'delete':
						/**
						 * Prior to deletion of entries. An array of Entry ID's is provided which
						 * can be manipulated. This delegate was renamed from `Delete` to `EntryPreDelete`
						 * in Symphony 2.3.
						 *
						 * @delegate EntryPreDelete
						 * @param string $context
						 * '/publish/'
						 * @param array $entry_id
						 *  An array of Entry ID's passed by reference
						 */
						Symphony::ExtensionManager()->notifyMembers('EntryPreDelete', '/publish/', array('entry_id' => &$checked));

						EntryManager::delete($checked);

						/**
						 * After the deletion of entries, this delegate provides an array of Entry ID's
						 * that were deleted.
						 *
						 * @since Symphony 2.3
						 * @delegate EntryPostDelete
						 * @param string $context
						 * '/publish/'
						 * @param array $entry_id
						 *  An array of Entry ID's that were deleted.
						 */
						Symphony::ExtensionManager()->notifyMembers('EntryPostDelete', '/publish/', array('entry_id' => $checked));

						break;
				}
			}
		}

		public function generateFieldsLink(array $section)
		{
			$html = ' ';
			foreach ($section['fields'] as $field) {
				$html .= '<br />' . Widget::Anchor(
					$field->section->get('name') . ': ' . $field->get('label') ,
					SYMPHONY_URL . '/publish/' . $field->section->get('handle') . '/'
				)->generate();
			}
			return $html;
		}

		public function generateOrphanTable(array $section)
		{
			// get visible columns
			$visible_columns = $section['section']->fetchVisibleColumns();
			// extract the needed schema
			$element_names = array_values(array_map(function ($field) {
				return $field->get('element_name');
			}, $visible_columns));
			
			$entries = $section['orphans'];
			$thead = array();

			if (is_array($visible_columns) && !empty($visible_columns)) {
				foreach ($visible_columns as $column) {
					$thead[] = array($column->get('label'));
				}
			} else {
				$thead[] = array(__('ID'));
			}
			
			$tbody = array();
			
			foreach ($entries as $orphan) {
				$td = array();
				$o = $this->entryManager->fetch($orphan, $section['section']->get('id'), null, null, null, null, false, true, $element_names, false);
				if (empty($o)) {
					$td[] = Widget::TableData("Entry $orphan not found", null, null, count($thead));
					$tbody[] = Widget::TableRow($td);
					continue;
				}
				if (is_array($o)) {
					$o = $o[0];
				}
				if (!$o || !is_object($o)) {
					// wrong section
					throw new Exception('Fectch an entry from an invalid section');
				}
				$link = $link = Widget::Anchor('',
					SYMPHONY_URL . '/publish/' . $section['section']->get('handle') . '/edit/' . $orphan . '/',
					$orphan,
					'content'
				);
				if (is_array($visible_columns) && !empty($visible_columns)) {
					foreach ($visible_columns as $column) {
						$data = $o->getData($column->get('id'));
						$td[] = Widget::TableData($column->prepareTableValue($data, $link, $orphan));
						$link = null;
					}
				} else {
					$link->setValue($orphan);
					$td[] = Widget::TableData($link);
				}
				$td[] = Widget::TableData(Widget::Input("items[$orphan]", null, 'checkbox', array(
					'id' => "entry-$orphan"
				)));
				$tbody[] = Widget::TableRow($td);
			}
			
			return Widget::Table(
				Widget::TableHead($thead), null,
				Widget::TableBody($tbody), 'selectable', null,
				array('role' => 'directory', 'aria-labelledby' => 'symphony-subheading', 'data-interactive' => 'data-interactive')
			)->generate();
		}

		public function normalizeDataPerSection(array $fields)
		{
			$allLinkedSections = array();
			foreach ($fields as $field) {
				foreach ($field->linkedSections as $section) {
					$sectionId = $section->get('id');
					if (!isset($allLinkedSections[$sectionId])) {
						$allLinkedSections[$sectionId] = array(
							'section' => $section,
							'fields' => array($field)
						);
					} else {
						$allLinkedSections[$sectionId]['fields'][] = $field;
					}
				}
			}
			foreach ($allLinkedSections as &$ls) {
				// All entries in that section
				$ls['all-entries'] = array_map(function ($e) {
					return $e['id'];
				}, $this->entryManager->fetch(null, $ls['section']->get('id'), null, null, null, null, false, false, null, false));
				// Merge all linked entries for each related field
				$ls['linked-entries'] = array();
				foreach ($ls['fields'] as $field) {
					$ls['linked-entries'] = array_merge($ls['linked-entries'], $field->linkedEntries);
				}
				// All linked entries that are in the all-entries (section based filtering)
				$ls['linked-entries'] = array_unique(array_intersect($ls['linked-entries'], $ls['all-entries']), SORT_NUMERIC);
				// All linked entries not in all-entries
				$ls['orphans'] = array_unique(array_diff($ls['all-entries'], $ls['linked-entries']), SORT_NUMERIC);
			}
			return $allLinkedSections;
		}

		public function getAllFieldsData()
		{
			$fields = $this->fieldManager->fetch(null, null, 'ASC', 'sortorder', 'entry_relationship');
			$fields = array_map(function ($f) {
				// Get the field's section
				$f->section = $this->sectionManager->fetch($f->get('parent_section'));
				// Get all linked entries from all entries in this field
				$f->linkedEntries = array();
				$fieldEntries = $this->entryManager->fetch(null, $f->get('parent_section'), null, null, null, null, false, true, array($f->get('element_name')), false);
				foreach ($fieldEntries as $fEntry) {
					$fedata = $fEntry->getData($f->get('id'));
					if (empty($fedata)) {
						continue;
					}
					// make section array dim
					$f->linkedEntries = array_merge($f->linkedEntries, array_filter(explode(',', $fedata['entries'])));
				}
				// Find all sections this field can be related with
				$f->linkedSections = array();
				$rSections = explode(',', $f->get('sections'));
				foreach ($rSections as $s) {
					$section = $this->sectionManager->fetch($s);
					$f->linkedSections[] = $section;
				}
				// Return new field object
				return $f;
			}, $fields);
			
			return $fields;
		}
	}
