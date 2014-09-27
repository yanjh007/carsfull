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
  
  public function get_sclass($id,$stype) { //0 已关联班级  1未关联班级
    $this->load->model("slink");
    
    if ($stype==0) { //已关联班级
      $sql = "select lid id,lname name from slinks where rid=".$id." and ltype=".Slink::TYPE_CLASS_COURSE;
    } else if($stype==1) { //未关联班级
      $sql= "select id,name from sclasses where utype=2 and id not in (select lid from ".Slink::TABLE_NAME." where ltype=".Slink::TYPE_CLASS_COURSE." and rid= ".$id.") ";  
    } else { //关联班级数量
      $sql=" select rid,rname,count(1) count from slinks where ltype=".Slink::TYPE_CLASS_COURSE." group by rid ";
    }
    
    $query = $this->db->query($sql);
    return $query->result_array(); 
  }
  
  public function get_sclass_counts($id,$stype) { //0 已关联班级  1未关联班级
    $this->load->model("slink");
    
    if ($stype==0) { //获取列表
      $sql = "select lid id,lname name from slinks where rid=".$id." and ltype=".Slink::TYPE_CLASS_COURSE;
    } else {
      $sql= "select id,name from sclasses where utype=2 and id not in (select lid from ".Slink::TABLE_NAME." where ltype=".Slink::TYPE_CLASS_COURSE." and rid= ".$id.") ";  
    }
    
    $query = $this->db->query($sql);
    return $query->result_array(); 
  }
  
  public function get_content($id,$ctype=0) {
    if ($ctype==0) {
      $sql =  "select id,name,mtype,morder,status from cmodules where course=".$id." order by morder";
  
      $query = $this->db->query($sql);
      return $query->result_array();
      
    } else {
      $sql =  "select id,name,mtype,morder,status,course,content from cmodules where id=".$id;
  
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
  
  public function save_module($course_id) {
    $table="cmodules";
    $item   = $this->input->post();
    $id = $item["item_id"];
    $data = array(
		'mtype'	=> $item["mtype"],
		'name' 	=> $item["name"],
		'content' => $item["content"],
	    );
    
    // 老位置    
    if ($id==0) {
      $sql = "select max(morder)+1 morder from ".$table." where course=".$course_id;
    } else {
      $sql = "select morder from ".$table." where id=".$id;
    }
    
    $query = $this->db->query($sql);
    $order = $query->row()->morder;
    if (!isset($order)) $order =1; 
    
    // 插入位置
    $morder=$item["morder"];
    if (!isset($morder) ||$morder=="") $morder=$order;
    
    if ($morder!=$order) { //次序变化
      //当前位置是否已被占有
      $sql="select 1 from ".$table." where morder=".$morder." and course=".$course_id;
      $query = $this->db->query($sql);
      
      if ($query->num_rows()>0) {
	$sql="update ".$table." set morder=morder+1 where morder>=".$morder." and morder<".$order;
	$this->db->query($sql);      
      }
    }    
    
    $data["morder"] = $morder;
    if ($id==0) { // insert      
      $data["course"] = $course_id;
      $this->db->insert($table, $data);
    } else {
      $this->db->where('id', $id);
      $this->db->update($table, $data); 
    }
    return TRUE;
  }
  
  
  public function remove($item_id) {
    $this->db->where('id', $item_id);
    $this->db->delete(self::TABLE_NAME);
    
    return TRUE;
  }
  
  public function remove_module($item_id) {
    
    $this->db->where('id', $item_id);
    $this->db->delete("cmodules");
    
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