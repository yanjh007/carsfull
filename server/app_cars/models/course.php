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
    if ($stype==10) { //已开启班级 $id为课程 以lesson为key
      $sql="select * from v_lesson_classes where course=".$id;
      $ary=array(); 
      $key=0; $str_list;
      $query = $this->db->query($sql);
      foreach ($query->result_array() as $row) {
		if ($row["module"]!=$key ) {
		  if ($key!=0) $ary[$key]=$str_list;
		  $ary_list=array();
		  $str_list=$row["class_name"];
		  $key=$row["module"];
		} else {
		  $str_list.="<br>".$row["class_name"];  
		}
	  
		$stime=date("m-d H:i",$row["stime"]*60);
		$etime=date("m-d H:i",$row["etime"]*60);
	  
		if ($row["status"]==1) {
		  $status="(关闭)";
		} else if ($row["status"]==2) {
		  $status="(开启)";
		} else if ($row["status"]==3) {
		  $status="(定时开启 ".$stime.")";
		} else if ($row["status"]==4) {
		  $status="(定时关闭 ".$etime.")";
		} else if ($row["status"]==5) {
		  $status="(".$stime."~".$etime.")";
		} else {
		  $status="";
		}
		$str_list.=" ".$status;
      }
	  
      if ($key!=0) { //最后一个
		$ary[$key]=$str_list;	
      }
      
      return $ary;
    }
    
    $this->load->model("slink");
    
    if ($stype==0) { //已关联班级
      $sql = "select lid id,lname name from slinks where rid=".$id." and ltype=".Slink::TYPE_CLASS_COURSE;
    } else if($stype==1) { //未关联班级
      $sql= "select id,name from sclasses where utype=2 and id not in (select lid from ".Slink::TABLE_NAME." where ltype=".Slink::TYPE_CLASS_COURSE." and rid= ".$id.") ";  
    } else if($stype==2) { //关联班级数量
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
    if ($ctype==0) { //获取特定课程的所有模块
      $sql =  "select id,name,mtype,morder,status from cmodules where course=".$id." order by morder";
  
      $query = $this->db->query($sql);
      return $query->result_array();      
    } else if($ctype==1) { //获取模块内容
      $sql =  "select id,name,mtype,morder,status,course,content from cmodules where id=".$id;
  
      $query = $this->db->query($sql);
      return $query->row_array();
    } else if ($ctype==2) { //获取模块对应的活跃课程状态
      $sql =  "select id,lcode,sclass,status,stime,etime from lessons where module=".$id;
  
      $query = $this->db->query($sql);
      $ary_status=array();
      if ($query->num_rows() > 0) foreach ($query->result_array() as $row){
	$ary_status[$row["sclass"]] = $row;
      }
    
      return $ary_status;            
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
  
  // 模块内容
  public function save_module_content($course_id) {
    $table="cmodules";
    $item   = $this->input->post();
    $id = $item["item_id"];
    $data = array(
		'content' => $item["content"],
		);

    $this->db->where('id', $id);
    $this->db->update($table, $data); 
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
  
  // 保存课堂
  public function save_lesson($id) { //模块id
    $item=$this->input->post();
 
    $stime= strtotime($item["stime"])/60;
    $etime= strtotime($item["etime"])/60;
      
    $lesson_id=$item["lesson_id"];
    $data = array(
		'sclass'	=> $item["class_id"],
		'status' 	=> $item["status"],
		'lcode'  	=> $item["lcode"],
		'module'  	=> $id,
		'stime'		=> $stime,
		'etime'		=> $etime,
	    );
    
    $table="lessons";
    if ($lesson_id==0) { // insert
      $this->db->insert($table, $data); 
    } else {
      $this->db->where('id', $lesson_id);
      $this->db->update($table, $data); 
    }
    return TRUE;
  }
  
  
  //用于接口
  public function if_slessons() { //学生课堂列表
    $user = $this->input->get_post('U');
	
	$sql = "select sclass from susers where id=".$user;
    $query = $this->db->query($sql);

    if ($query->num_rows() > 0) {
		$sclass=$query->row()->sclass;
		
		$sql="select * from v_lessons where sclass=".$sclass;	
		
		$query = $this->db->query($sql);
	
		if ($query->num_rows() > 0) {
		  $data["content"] = json_encode($query->result_array());
		} else {
		  $data["result"] = "NULL";
		}	
    } else {
      $data["result"] = "NULL";
    }		
	

    return $data;  
  }

}