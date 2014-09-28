<?php
class Sclass extends CI_Model {
  const TABLE_NAME = 'sclasses';
  const STD_SQL_QUERY  = 'SELECT id,pid,scode,name,address,contact,gyear,utype FROM sclasses ';
  
  public function __construct() {
    $this->load->database();
  }

  public function search($keyword = FALSE) {
    $sql= self::STD_SQL_QUERY;
    if ($keyword) {
      $sql=$sql." where name like '%".$keyword."%' ";
    }
    
    $sql= $sql." order by scode limit 20";

    $query = $this->db->query($sql);
    return $query->result_array();
  }

  //学校列表
  public function get_schools($id=0) {
    if ($id==0) {
      $sql= self::STD_SQL_QUERY." where utype=0 and pid=0 order by scode";
      $query = $this->db->query($sql);
      return $query->result_array();
    } else {
      $sql= self::STD_SQL_QUERY." where id=".$id ;
      $query = $this->db->query($sql);
      return $query->row_array();
    }
  }

  //班级列表
  public function get_sclass($pid,$id=0){
    if ($id==0) { //输入列表
      if ($pid==0) {
	$sql= "select * from v_sclasses";
      } else {
	$sql= "select * from v_sclasses where pid=".$pid;
      }
      
      $query = $this->db->query($sql);
      return $query->result_array();
    } else {
      $sql= self::STD_SQL_QUERY." where id=".$id ;
      $query = $this->db->query($sql);
      return $query->row_array();
    }
  }
  
  //成员列表
  public function get_members($id,$mtype=0) { //id是班级id
    $sql="select id,stype,snumber,sclass,name from susers";
    
    if ($mtype==0) { //班级教员列表
      $this->load->model("slink");
      $sql="select u.id,u.name,u.stype,u.sclass,u.snumber from slinks l left join susers u on u.id=l.rid where ltype=".Slink::TYPE_CLASS_TEACHER." and lid=".$id;

      $query= $this->db->query($sql);
      return $query->result_array();
    } else if ($mtype==1){ //学员列表 
      $query = $this->db->query($sql." where sclass=".$id." and stype=2 order by snumber");
      return $query->result_array();
    } else if ($mtype==2) { //学校教员列表
      $query = $this->db->query($sql." where sclass=".$id." and (stype=0 or stype=1) order by snumber");
      
      return $query->result_array();
    
    }
  }
  
  public function get_member($id) { //id是班级id
    $sql="select id,stype,snumber,sclass,name from susers where id=".$id;
    $query = $this->db->query($sql);
    return $query->row_array();
  }
  
  public function get_courses($id,$stype) { //0 已关联课程  1未关联课程
    $this->load->model("slink");
    
    if ($stype==0) { //获取列表
      $sql = "select rid id,rname name from slinks where lid=".$id." and ltype=".Slink::TYPE_CLASS_COURSE;
    } else if ($stype==1){
      $sql= "select id,name from courses where id not in (select rid from ".Slink::TABLE_NAME." where ltype=".Slink::TYPE_CLASS_COURSE." and lid= ".$id.") ";  
    } else if ($stype==2){
      $sql= "select lesson_id,name,module,mtype,stime,etime,status from v_lessons where sclass=".$id;
    } else {
      return NULL;
    }
    
    $query = $this->db->query($sql);
    return $query->result_array(); 
  }
  
  public function save($item,$id,$utype) {
    $data = array(
		  'scode'   => $item["scode"],
		  'name'    => $item["name"],
		  'contact' => $item["contact"],
		  'address' => $item["address"],
		  'utype'   => $utype,
		   );
    if ( $utype==2 ) {
      $data["gyear"]=$item["gyear"];
      $data["pid"]  =$item["school"];
    }
    
    if ($id==0) { // insert
      $this->db->insert(self::TABLE_NAME, $data);
      return $this->db->insert_id();
    } else {
      $this->db->where('id', $id);
      $this->db->update(self::TABLE_NAME, $data);
      return $id;
    }	
  }
  
  
  
  public function remove($item_id) {
    $this->db->where('id', $item_id);
    $this->db->delete(self::TABLE_NAME); 

    return TRUE;
  }
  
  // 选择用列表
  public function school_list() {
    $sql="select id,CONCAT(scode,'-',name) value from ".self::TABLE_NAME." where utype=0 and pid=0 order by scode";
    $query = $this->db->query($sql);
    return $query->result_array();
  }
  
  public function save_member($item,$classid) {
    $id= $item["item_id"];
    
    $data = array(
		  'snumber' => $item["snumber"],
		  'name'    => $item["name"],
		   );
    
    if ($id==0) { // insert
      $data["sclass"] =$item["sclass"];
      $data["stype"]  =$item["stype"];
      
      $this->db->insert("susers", $data);
      return $this->db->insert_id();
    } else {
      $this->db->where('id', $id);
      $this->db->update("susers", $data);
      return $id;
    }	
  }
  
  public function add_member($classid) {
    $snumber= $this->input->post("snumber");
    $school = $this->input->post("school_id");
    
    $sql="select id,name,stype from susers where stype=0 and snumber ='".$snumber."' and sclass=".$school;
    $query = $this->db->query($sql);
    if ($query->num_rows()>0) {
      $row=$query->row();
      
      $this->load->model("slink");
      $this->slink->link(Slink::TYPE_CLASS_TEACHER,$classid,"",$row->id,$row->name);
      return TRUE;
    } else {
      return FALSE;
    }
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