<?php
class Sreport extends CI_Model {
  const TABLE_NAME = 'sreports';
  const STD_SQL_QUERY  = 'SELECT uid,mid,answer,score,rnote FROM sreports ';
  
  public function __construct() {
    $this->load->database();
  }

  //班级报告列表 id为班级id
  public function get_score_ary($sclass,$mid){ //班级 - 模块成绩列表
	$sql ="select uid,qorder,score,status from sreports where uid in (select id from susers where sclass=".$sclass." and stype=2) 
and mid= ".$mid;

	$query = $this->db->query($sql);      
    return $query->result_array();
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
    $uid = $this->input->post("U");
	$content = $this->input->post("content");	
	$lessons = json_decode($content,true);
	
	if (count($lessons)==0) return FALSE;
	
	// 课程-答案列表
	$data=array();
	$mids="0";
	foreach ($lessons as $lesson) { //内容集合
	  $lid=$lesson["lid"];
	  $sql="select module from lessons where id=".$lid;
      $query = $this->db->query($sql);
      if ($query->num_rows()>0) {
		$mid=$query->row()->module;	
	  } else {
		$mid=0;
	  }
	  
	 
	  if ($mid>0) {
		$answer=json_decode($lesson["answer"],true);
		$mids.=",".$mid;
		foreach ($answer as $aitem) {
			$data[]=array(
						  'uid' => $uid,
						  'mid' => $mid,
						  'qorder' => $aitem["qorder"],
						  'answer' => $aitem["answer"], //用户答案
						  'score'  => $aitem["score"],
						  'status' => $aitem["result"] //结果 0-未答 1-错误 2-正确 3-待审 4-已审
						  );
		}
	  }
	}
	
	var_dump($data);
	//批量插入
	if (count($data)>0) {
	  $this->db->query("delete from sreports where uid=".$uid." and mid in (".$mids.")");
	  $this->db->insert_batch('sreports', $data);
	}
	return TRUE;
  }
  
  // 学生报告同步接口
  public function if_sreport() {
  
  }

  // 学生报告家长接口
  public function if_preport() {
  
  }

  
}