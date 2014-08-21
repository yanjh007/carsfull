<?php
class Shop extends CI_Model {
  const SQLQUERY  = 'SELECT id,scode,name,address,contact FROM shops ';
  const TABLENAME = 'shops';
  
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
  
  public function save($item) {
    $data = array(
		  'scode'   => $item["scode"],
		  'name'    => $item["name"],
		  'contact' => $item["contact"],
		  'address' => $item["address"],
		   );

    if (isset($item["item_id"]) ) { // insert
      $this->db->where('id', $item["item_id"]);
      $this->db->update(self::TABLENAME, $data); 
    } else {
      $this->db->insert(self::TABLENAME, $data); 
    }
    return TRUE;
  }
  
  public function remove($item_id) {
    $this->db->where('id', $item_id);
    $this->db->delete(self::TABLENAME); 
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