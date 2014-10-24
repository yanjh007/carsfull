<?php
class Sreport extends CI_Model {
  const TABLE_NAME = 'sreports';
  const STD_SQL_QUERY  = 'SELECT uid,mid,answer,score,rnote FROM sreports ';
  
  public function __construct() {
    $this->load->database();
  }

  //班级报告列表 id为班级id
  public function get_sclass($id){
    if ($id==0) { //输入列表
      $sql= "select * from v_sclasses";
      if ($pid>0) $sql.= " where pid=".$pid;
      
      $query = $this->db->query($sql);
      return $query->result_array();
    } else {
      $sql= self::STD_SQL_QUERY." where id=".$id ;
      $query = $this->db->query($sql);
      return $query->row_array();
    }
  }
  
    //班级报告列表 id为学生id
  public function get_suser($id){
    if ($id==0) { //输入列表
      $sql= "select * from v_sclasses";
      if ($pid>0) $sql.= " where pid=".$pid;
      
      $query = $this->db->query($sql);
      return $query->result_array();
    } else {
      $sql= self::STD_SQL_QUERY." where id=".$id ;
      $query = $this->db->query($sql);
      return $query->row_array();
    }
  }
  


  //学生报告提交接口  
  public function if_commit() { 
    $uid = $this->input->post("uid");
    $sql="delete from sreports where uid=".$uid." and $mid=".$mid;
	
	//内容集合
    $content= $this->input->post("content");
	$list=json_decode($content,true);
	
	$data=array();
	foreach ($list as $item) {
		$data[]=array(
					  'uid' => $id,
					  'mid' => $item["mid"],
					  'answer' => $item["answer"],
					  'score'  => $item["score"],					  
					  );
	}
	//批量插入
	if (count($data)>0) $this->db->insert_batch('sreports', $data);

	return TRUE;
  }
  
  // 学生报告同步接口
  public function if_sreport() {
  
  }

  // 学生报告家长接口
  public function if_preport() {
  
  }

  
}