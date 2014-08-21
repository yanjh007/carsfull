<?php
class Carmodel extends CI_Model {
  const SQLQUERY  = "SELECT id,mcode,mname,manufacturer,brand,ctype FROM carmodels ";
  const TABLENAME = "carmodels";
  
  public function __construct() {
    $this->load->database();
  }

  public function search($keyword = FALSE) {
    $sql =  self::SQLQUERY;
    if ($keyword) {
      $sql=$sql." where mcode like '%".$keyword."%' or manufacturer like '%".$keyword."%' or brand like '%".$keyword."%'";
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
           'mcode'     => $item["mcode"],
           'mname'      => $item["mname"],
           'manufacturer' => $item["manufacturer"],
           'brand' 		=> $item["brand"],
           'ctype'  => $item["ctype"],
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

}