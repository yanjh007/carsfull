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

  // 网络接口用方法
  function get_cars_list($clientid) {
    $sql= "select carnumber,manufacturer,brand,descp from v_carsofuser where uid =".$clientid;

    $query = $this->db->query($sql);
    return  $query->result_array(); 
  }
  
  function if_cars_list() {
    // 版本
    $clientid= $this->input->get_post("U");
    $version = $this->input->get_post("V");
    
    if (!$version) $version=0;
      
    $this->load->model("zmversion");
    $version2 = $this->zmversion->check_version("cars_user_".$clientid,$version);
    if ($version2>0) { 
      $content["version"] = $version2;
      $content["cars"] = $this->get_cars_list($clientid);
  
      $data["content"] = json_encode($content);      
    } else { //无更高版本
      $data["result"]="NULL"; 
    }
    return $data;
  }
  
  function if_cars_update() {
    $cars =$this->input->put("C");
    
    if ($cars) {
      $strupdate="";
      $ary=json_decode($cars,TRUE);
      foreach ($ary as $item) {
	
	$strupdate.= ($strupdate=="")?$item["carnumber"]:",".$item["carnumber"];
      }
      $data["content"] = json_encode(array("updated"=>$strupdate));	
    
    } else {
	$data["result"]="FALSE"; //数据交付格式错误
	$data["content"] = json_encode(array("status"=>21,"error"=>"数据为空"));	
    }
    
    return $data;
  }
}