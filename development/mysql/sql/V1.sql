ALTER TABLE session ADD INDEX index_value (value);
ALTER TABLE record ADD INDEX index_order (updated_at DESC, record_id ASC);