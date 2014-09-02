<?php
Class Zmversion extends CI_Model {
  const TABLE_NAME  = 'zm_versions';
  
  function checkVersion($key,$value) {
    $query = $this->db->query("SELECT vvalue FROM ".self::TABLE_NAME." where vkey =? and vvalue> ? limit 1",array($key,$value));
	if ($query -> num_rows() > 0) {
	  return $query->row()->vvalue;
	} else {
	  return  0;
	}
  }
  
  function setVersion($key) {
    $query = $this->db->query("SELECT 1 FROM ".self::TABLE_NAME." where vkey = ?",$key);
    if ($query -> num_rows() > 0) {
	  $this->db->set('vvalue', 'vvalue+1', FALSE);
	  $this->db->update(self::TABLE_NAME,NULL,array("vkey"=>$key));
	} else {
	  $this->db->insert(self::TABLE_NAME,array("vvalue"=>1,"vkey"=>$key));
	}
  }
}
?>
