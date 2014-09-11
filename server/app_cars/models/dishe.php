<?php
class Dishe extends CI_Model {
  const SQLQUERY  = 'SELECT id,dtype,dcode,name,price,descp FROM dishes  ';
  const TABLE_NAME = 'dishes';
  
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
  
  public function save($id,$item) {    
    $data = array(
		  'dcode'   => $item["dcode"],
		  'name'    => $item["name"],
		  'price' => $item["price"],
		  'descp' => $item["descp"],
		   );

    if ($id>0) { // update
      $this->db->where('id', $id);
      $this->db->update(self::TABLE_NAME, $data);
      
      // 更新连接名称
      $this->load->model('link');
      $this->link->setlname(Link::TYPE_DISHE_CATAS,$id,$data["name"]);
      $this->link->setlname(Link::TYPE_DISHE_SETS, $id,$data["name"]);
    } else { // insert
      $data['dtype'] = $item["dtype"];
      $this->db->insert(self::TABLE_NAME, $data); 
    }
	
    return TRUE;
  }
  
  public function remove($id) {
    $this->db->where('id', $id);
    $this->db->delete(self::TABLE_NAME); 

    //删除链接
    $this->load->model('link');
    $this->link->unlink(Link::TYPE_DISHE_CATAS,$id,0);
    $this->link->unlink(Link::TYPE_DISHE_SETS, $id,0);
    
    return TRUE;
  }
  
  // 选择用列表
  public function select_list() {
    $sql="select id,scode,name from shops order by scode";
    $query = $this->db->query($sql);
    return $query->result_array();
  }
  
  
  // 获取类别套餐或单品列表
  public function get_cata_dishes($dtype,$cata) {
    $this->load->model('link');
    $sql= "select id,dcode,name,price,descp from dishes where dtype = ".$dtype." and id in (select lid from links where ltype=".Link::TYPE_DISHE_CATAS." and rid=".$cata.") order by price";

    $query = $this->db->query($sql);
    return $query->result_array();
  }  

  // 获取套餐或单品列表
  public function get_dishes($dtype) {
    $sql= "select id,dcode,name,price,descp from dishes where dtype = ".$dtype." order by price";

    $query = $this->db->query($sql);
    return $query->result_array();
  }
  
  // 从字典中获取分类名称和列表
  public function get_cata_name($cata) {
    $sql= "select name from dic where id =".$cata." limit 1";

    $query = $this->db->query($sql);
    return $query->row()->name;
  }
  
  public function get_catas() {
    $sql= "select id,did,name from dic where dtype=8 and did>0 and did<100 order by did ";

    $query = $this->db->query($sql);
    return $query->result_array();
  }
  
  public function get_links($id,$link) {
    $this->load->model('link');
    if ($link==0) {
      return $this->link->rlist(Link::TYPE_DISHE_CATAS,$id);      
    } else if ($link==1) {
      $sql= "select id,did,name from dic where dtype=8 and did>0 and did<100 and id not in (select rid from links where ltype=".Link::TYPE_DISHE_CATAS." and lid= ".$id.") ";  
      $query = $this->db->query($sql);
      return $query->result_array();
    } else if ($link==2) {
      return $this->link->rlist(Link::TYPE_DISHE_SETS,$id); 
    } else if ($link==3) { //未关联套餐
      $sql= "select id,name from ".self::TABLE_NAME." where dtype=1 and id not in (select rid from links where ltype=".Link::TYPE_DISHE_SETS." and lid= ".$id.") ";  
      $query = $this->db->query($sql);
      return $query->result_array();      
    }
  }
}