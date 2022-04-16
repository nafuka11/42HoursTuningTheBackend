ALTER TABLE session ADD INDEX index_value (value);
ALTER TABLE record ADD INDEX index_order (updated_at DESC, record_id ASC);
ALTER TABLE record_comment ADD INDEX index_linked_record_id (linked_record_id);
ALTER TABLE record_item_file ADD INDEX index_linked_record_id (linked_record_id);