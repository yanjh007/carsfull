<?php
class Course extends CI_Model {
  const TABLE_NAME = "courses";
  const STD_SQL_QUERY  = "SELECT id,ccode,name,ccata,descp FROM courses";
  
  public function __construct() {
    $this->load->database();
  }

  public function search($keyword = FALSE) {
    $sql =  self::STD_SQL_QUERY;
    if ($keyword) {
      $sql=$sql." where mcode like '%".$keyword."%' or manufacturer like '%".$keyword."%' or brand like '%".$keyword."%'";
    }
    
    $sql= $sql." order by manufacturer,version desc limit 20";

    $query = $this->db->query($sql);
    return $query->result_array();
  }

  public function get_course($id,$ccata="") {
    $sql =  self::STD_SQL_QUERY;
    if ($id==0) { //获取列表
      if ($ccata!="") $sql .= " where ccata ='".$ccata."'";
      $sql.= " order by ccode limit 30";
      $query = $this->db->query($sql);
      return $query->result_array();      
    } else {
      $sql.=" where id=".$id;
      $query = $this->db->query($sql);
      return $query->row_array();
    }
  }
    
  public function save($item,$id) {
      $data = array(
		  'ccode'	=> $item["ccode"],
		  'name' 	=> $item["name"],
		  'ccata'  	=> $item["ccata"],
	      );
    
      if ($id==0) { // insert
        $this->db->insert(self::TABLE_NAME, $data); 
      } else {
	$this->db->where('id', $id);
	$this->db->update(self::TABLE_NAME, $data); 
      }
    return TRUE;
  }
  
  
  public function remove($item_id) {
    $this->db->where('id', $item_id);
    $this->db->delete(self::TABLE_NAME);
    
    return TRUE;
  }
  
  
  //用于接口
  public function if_tag() {
    $tag = $this->input->get_post('K');
    $sql="select id,manufacturer,brand,tags,engine_list,trans_list,descp from ".self::TABLE_NAME." where tags like '%".$tag."%' order by manufacturer";	
	
    $query = $this->db->query($sql);

    if ($query->num_rows() > 0) {
      $data["content"] = json_encode($query->result_array());
    } else {
      $data["result"] = "NULL";
    }	

    return $data;  
  }

}