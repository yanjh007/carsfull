<?php
Class Zmversion extends CI_Model {
  const TABLE_NAME  = 'zm_versions';
  
  public function __construct() {
    $this->load->database();
  }
  
  function check_version($key,$value) {
      $query = $this->db->query("SELECT vvalue FROM ".self::TABLE_NAME." where vkey =? and vvalue > ? limit 1",array($key,$value));
      if ($query -> num_rows() > 0) {
	return $query->row()->vvalue;
      } else {
	return  0;
      }
  }
  
  function set_version($key) {
    $query = $this->db->query("SELECT vvalue FROM ".self::TABLE_NAME." where vkey = ?",$key);
    if ($query -> num_rows() > 0) {
      $value= $query->row()->vvalue+1;
      //$this->db->set('vvalue', 'vvalue+1', FALSE);
      $this->db->where('vkey', $key);
      $this->db->update(self::TABLE_NAME,array("vvalue"=>$value));
      return $value+1;
    } else {
      $this->db->insert(self::TABLE_NAME,array("vvalue"=>1,"vkey"=>$key));
      return 1;
    }
  }
}
?>
