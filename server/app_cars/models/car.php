<?php
class Car extends CI_Model {
  const SQLQUERY    = 'SELECT id,carnumber,manufacturer,brand,descp FROM cars ';
  const TABLE_NAME  = 'cars';	
  
  public function __construct() {
    $this->load->database();
  }

  public function search($keyword = FALSE) {
    $sql=self::SQLQUERY;
    if ($keyword) {
      $sql=$sql." where carnumber like '%".$keyword."%' or manufacturer like '%".$keyword."%' or brand like '%".$keyword."%'";
    }
    
    $sql= $sql." order by edit_at desc limit 20";

    $query = $this->db->query($sql);
    return $query->result_array();
  }

  public function get_one($id){
    $query = $this->db->query(self::SQLQUERY." where id=?",$id);
    return $query->row_array();
  }
  
  public function save($item) {
    $data = array(
			'carnumber' => $item["carnumber"],
			'descp' => $item["descp"],
          );
    
	if (isset($item["item_id"]) ) { // insert
        $this->db->where('id', $item["item_id"]);
        $this->db->update(self::TABLE_NAME, $data); 
	} else {
        $this->db->insert(self::TABLE_NAME, $data); 
	}
    return TRUE;
  }
  
  public function remove($id) {
    $this->db->where('id', $id);
    $this->db->delete(self::TABLE_NAME); 
    return TRUE;
  }
  
  function get_passwd_by_login($login) {
    $query = $this->db->query("SELECT passwd FROM clients where login ='".$login."' limit 1");

    if($query -> num_rows() > 0) {
      return $query->row()->passwd;
    } else {
        return NULL;
    }
  }
}