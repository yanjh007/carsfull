<?php
class Car extends CI_Model {
  public function __construct() {
    $this->load->database();
  }

  public function search($keyword = FALSE) {
    $sql="SELECT id,carnumber,manufacturer,brand FROM cars" ;
    if ($keyword) {
      $sql=$sql." where carnumber like '%".$keyword."%' or manufacturer like '%".$keyword."%' or brand like '%".$keyword."%'";
    }
    
    $sql= $sql." order by edit_at desc limit 20";

    $query = $this->db->query($sql);
    return $query->result_array();
  }

  public function get_car($cid){
    $sql="SELECT id,carnumber,manufacturer,brand FROM cars where id=".$cid ;
	var_dump($sql);
    $query = $this->db->query($sql);
    return $query->row_array();
  }
  
  public function save($car) {
	if (isset($car["car_id"]) ) { // insert
        $carid= $car["car_id"];    
        $data = array(
               'carnumber' => $car["carnumber"],
               'manufacturer'   => $car["manufacturer"],
               'brand' => $car["brand"],
              );
        $this->db->where('id', $carid);
        $this->db->update('clients', $data); 
	} else {
        $data = array(
               'carnumber' => $car["carnumber"],
               'manufacturer'   => $car["manufacturer"],
               'brand' => $car["brand"],
              );
        $this->db->insert('clients', $data); 
	}
    return TRUE;
  }
  
  public function remove($car_id) {
    $this->db->where('id', $car_id);
    $this->db->delete('clients'); 
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