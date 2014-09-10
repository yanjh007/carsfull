<?php
class Dishe extends CI_Model {
  const SQLQUERY  = 'SELECT id,dtype,name,price,descp FROM dishes  ';
  const TABLENAME = 'deshes';
  
  public function __construct() {
    $this->load->database();
  }

  public function search($keyword = FALSE) {
    $sql= self::SQLQUERY;
    if ($keyword) {
      $sql=$sql." where name like '%".$keyword."%' ";
    }
    
    $sql= $sql." order by scode limit 20";

    $query = $this->db->query($sql);
    return $query->result_array();
  }

  public function get_item($id){
    $sql= self::SQLQUERY." where id=".$id ;
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
	
	$this->load->model('zmversion');
    $this->zmversion->setVersion("shop_version");
    return TRUE;
  }
  
  public function remove($item_id) {
    $this->db->where('id', $item_id);
    $this->db->delete(self::TABLENAME); 

	$this->load->model('zmversion');
    $this->zmversion->setVersion("shop_version");
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
  
  
    // 从字典中获取分类列表
  public function get_dishes($dtype) {
    $sql= "select id,name,price,descp from dishes where dtype = ".$dtype." order by price";

    $query = $this->db->query($sql);
    return $query->result_array();
  }  
  // 从字典中获取分类列表
  public function get_catas() {
    $sql= "select id,did,name from dic where dtype=8 and did>0 order by did ";

    $query = $this->db->query($sql);
    return $query->result_array();
  }
  
  public function get_catas1($id) {
    $this->load->model('link');
    return $this->link->rlist(Link::TYPE_DISHE_CATAS,$id);
  }
  
  public function get_catas2($id) {
    $this->load->model('link');
    
    $sql= "select id,did,name from dic where dtype=8 and did>0 and did<100 and id not in (select rid from links where ltype=".Link::TYPE_DISHE_CATAS." and lid= ".$id.") ";

    $query = $this->db->query($sql);
    return $query->result_array();
  }  
}