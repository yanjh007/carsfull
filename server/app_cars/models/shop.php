<?php
class Shop extends CI_Model {
  const SQLQUERY = 'SELECT id,scode,name,address,contact FROM shops ';
  
  public function __construct() {
    $this->load->database();
  }

  public function search($keyword = FALSE) {
    $sql= Shop::SQLQUERY;
    if ($keyword) {
      $sql=$sql." where name like '%".$keyword."%' ";
    }
    
    $sql= $sql." order by scode limit 20";

    $query = $this->db->query($sql);
    return $query->result_array();
  }

  public function get_shop($sid){
    $sql= Shop::SQLQUERY." where id=".$sid ;
    $query = $this->db->query($sql);
    return $query->row_array();
  }
  
  public function save($shop) {
	$data = array(
			'scode'   => $shop["scode"],
			'name'    => $shop["name"],
			'contact' => $shop["contact"],
			'address' => $shop["address"],
			 );

	if (isset($shop["shop_id"]) ) { // insert
        $this->db->where('id', $shop["shop_id"]);
        $this->db->update('shops', $data); 
	} else {
        $this->db->insert('shops', $data); 
	}
    return TRUE;
  }
  
  public function edit($shop_id) {
    $this->db->where('id', $shop_id);
    $this->db->delete('shops'); 
    return TRUE;
  }
  
  public function remove($shop_id) {
    $this->db->where('id', $shop_id);
    $this->db->delete('shops'); 
    return TRUE;
  }
  
  // 选择用列表
  public function select_list() {
	$sql="select id,scode,name from shops order by scode";
	$query = $this->db->query($sql);
    return $query->result_array();
  }
  
  public function link($shop) {
    $car_number = $shop["carnumber"];
	if (isset($car_number) ) {
      $query = $this->db->query("SELECT id FROM cars where carnumber ='".$car_number."' limit 1");
      if($query ->num_rows() > 0) {
        $car_id = $query->row()->id;
        
        $query = $this->db->query("SELECT 1 FROM links where ltype=1 and lid = ".$shop["shop_id"]." and rid=".$car_id." limit 1");  
        if($query -> num_rows() == 0) {
          $data = array(
                 'ltype'  => '1',
                 'lid'    => $shop["shop_id"],
                 'lname'  => $shop["shop_name"],
                 'rid'    => $car_id,
                 'rname'  => $car_number,
                );
          $this->db->insert('links', $data); 
          return TRUE;
        }         
      }
	}
    return NULL;
  }
  
}