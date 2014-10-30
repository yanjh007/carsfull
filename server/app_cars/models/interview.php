<?php
class Interview extends CI_Model {
  const STD_SQL_QUERY  = 'SELECT exam,eorder,content FROM itvquestions';
  const TABLE_NAME = 'interviews';
  
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

  public function get_user(){
	$contact=$this->input->post('contact');
	$itype  =$this->input->post('itype');
	$passwd =$this->input->post('passwd');
	
	$sql="select contact,name,answer,passwd,itype,itime,flag from itvusers where contact='".$contact."' and itype=".$itype." limit 1";
    $query = $this->db->query($sql);
    if ($query->num_rows()>0) { //有记录，验证密码
	  $row=$query->row_array();
	  if ($row["passwd"]==$passwd) {
		return $row;
	  } else { //登录验证失败
		return array("flag"=>-1);
	  }
	} else { //无记录，添加记录
	  
	  $uname =$this->input->post('uname');
	  $data=array("passwd"	=>$passwd,
				  "contact" =>$contact,
				  "name"	=>$uname,
				  "flag"	=>0,
				  "itype"	=>$itype,
				  "itime"	=>time()/60,
				  "answer"	=>"",
				  );
	  $this->db->insert("itvusers",$data);
	  return $data;
	}	
  }  
  
  public function get_question($id,$exam){
	if ($id==0) {
	  $sql= self::STD_SQL_QUERY." order by eorder";
	  $query = $this->db->query($sql);
	  return $query->result_array();	  
	} else {
	  $sql= self::STD_SQL_QUERY." where exam=".$exam." and eorder=".$id;
	  $query = $this->db->query($sql);
	  return $query->row_array();	  
	}
  }
  
  public function get_answer($id,$exam,$user){
	$sql="select eorder,answer from itvanswers ";
	if ($id==0) {
	  $sql .= "where exam=".$exam." and contact='".$user."' order by eorder";
	  $query = $this->db->query($sql);
	  return $query->result_array();	  
	} else {
	  $itype=$this->input->get("itype");
	  $sql .= " where exam=".$exam." and eorder=".$id." and contact='".$user."'";
	  $query = $this->db->query($sql);
	  return $query->row_array();	  
	}
  }
  
  public function save($id,$exdata) { //id为eorder	
	$contact=$exdata["user"];
	$itype	=$exdata["itype"];
	
	$sql="delete from itvanswers where contact='".$contact."' and exam=".$itype." and eorder=".$id;
	$this->db->query($sql); 
	
    $data = array(
		  'contact' => $contact,
		  'exam'    => $itype,
		  'eorder' 	=> $id,
		  'answer' 	=> $this->input->post("answer"),
		   );
	
	$this->db->insert("itvanswers", $data);
	
    return TRUE;
  }
  
  public function commit($id,$exdata) {
	$contact=$exdata["user"];
	$itype	=$exdata["itype"];

	$data=array("flag"=>1);
	
    $this->db->where(array("contact"=>$contact,"itype"=>$itype));
    $this->db->update("itvusers",$data); 

    return TRUE;
  }
  
  // 选择用列表
  public function select_list() {
    $sql="select id,scode,name from shops order by scode";
    $query = $this->db->query($sql);
    return $query->result_array();
  }
  
 
}