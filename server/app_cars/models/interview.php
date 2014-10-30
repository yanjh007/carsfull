<?php
class Interview extends CI_Model {
  const STD_SQL_QUERY  = 'SELECT exam,eorder,content,score FROM itvquestions';
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
	
	$sql="select contact,name,answer,passwd,itype,itime,flag,score from itvusers where contact='".$contact."' and itype=".$itype." limit 1";
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
	  $sql= self::STD_SQL_QUERY." where exam=".$exam." order by eorder";
	  $query = $this->db->query($sql);
	  return $query->result_array();	  
	} else {
	  $sql= self::STD_SQL_QUERY." where exam=".$exam." and eorder=".$id;
	  $query = $this->db->query($sql);
	  return $query->row_array();	  
	}
  }
  
  public function get_answer($id,$exam,$user){
	$sql="select eorder,answer,score from itvanswers ";
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
  
  
  // 审核
  public function get_review($exam,$user){
	if ($exam==0) { //review列表
	  $sql = "select contact,name,itype,itime,flag,score from itvusers where flag>=1 order by itime desc";
	  $query = $this->db->query($sql);
	  return $query->result_array();	  
	} else {
	  $itype=$this->input->get("itype");
	  $sql = "select eorder,answer from itvanswers where exam=".$exam." and eorder=".$id." and contact='".$user."'";
	  $query = $this->db->query($sql);
	  return $query->row_array();	  
	}
  }
  
  public function save($id,$exdata) { //id为eorder	
	$contact=$exdata["user"];
	$itype	=$exdata["itype"];
	$next	=$exdata["next"];
	
	$sql="delete from itvanswers where contact='".$contact."' and exam=".$itype." and eorder=".$id;
	$this->db->query($sql); 
	
    $data = array(
		  'contact' => $contact,
		  'exam'    => $itype,
		  'eorder' 	=> $id,
		  'answer' 	=> $this->input->post("answer"),
		   );
	
	$this->db->insert("itvanswers", $data);
	
	if ($next==1) {
	  $sql="select eorder from itvquestions where eorder not in(select eorder from itvanswers where exam=".$itype." and contact='".$contact."') and  exam=".$itype." limit 1";
	  $query = $this->db->query($sql);
	  if ($query->num_rows()>0) return $query->row()->eorder;  
	}
	
	return 0;
	
  }
  
  public function commit($id,$exdata) {
	$contact=$exdata["user"];
	$itype	=$exdata["itype"];

	$data=array("flag"=>1);
	
    $this->db->where(array("contact"=>$contact,"itype"=>$itype));
    $this->db->update("itvusers",$data); 

    return TRUE;
  }

  public function review_commit($id) {
	$post=$this->input->post();
	$contact=$post["contact"];
	
	$sql="select eorder from itvanswers where exam=".$id." and contact='".$contact."'";
	$query = $this->db->query($sql);
  	$sum=0;
	if ($query->num_rows()>0) foreach($query->result_array() as $item){
	  $eorder=$item["eorder"];
	  $key="score_".$eorder;
	  if (isset($post[$key])) {
		$score=$post[$key];
		$this->db->where(array("contact"=>$contact,"eorder"=>$eorder));
		$this->db->update("itvanswers",array("score"=>$score)); 	  
		$sum+=$score;
	  }
	}
	

	$data=array("flag"=>2,
				"score"=>$sum,
				);
	
	$this->db->where(array("contact"=>$contact,"itype"=>$id));
	$this->db->update("itvusers",$data); 	  

    return TRUE;
  }
  
 
}