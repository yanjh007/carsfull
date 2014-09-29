<?php
Class Zmmeta extends CI_Model {
  const TABLE_NAME  = 'zm_metas';
  
  public function __construct() {
    $this->load->database();
  }
  
  function get_meta($key) {
      $query = $this->db->query("SELECT mvalue FROM ".self::TABLE_NAME." where mkey ='".$key."'");
      if ($query -> num_rows() > 0) {
	return $query->row()->mvalue;
      } else {
	return NULL;
      }
  }
  
  function set_meta($key,$value) {
    $query = $this->db->query("SELECT 1 FROM ".self::TABLE_NAME." where mkey = ?",$key);
    if ($query -> num_rows() > 0) {
      $this->db->where('mkey', $key);
      $this->db->update(self::TABLE_NAME,array("mvalue"=>$value));
    } else {
      $this->db->insert(self::TABLE_NAME,array("mvalue"=>$value,"mkey"=>$key));
    }
  }
}
?>
