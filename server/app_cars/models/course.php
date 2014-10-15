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
  
  public function get_sclass($id,$stype) { //0 已关联班级  1未关联班级 10 已关联班级和状态信息
    if ($stype==10) { //已开启班级 $id为课程 以lesson为key
      $sql="select * from v_lesson_classes where course=".$id;
      $ary=array(); 
      $key=0;
	  $sclass_list; // lesson对于的班级列表
      $query = $this->db->query($sql);
      foreach ($query->result_array() as $row) {
		if ($row["module"]!=$key ) {
		  if ($key!=0) $ary[$key]=$sclass_list;
		  $sclass_list=array();
		  $key=$row["module"];
		}
	  
		array_push($sclass_list,$row);
      }
	  
      if ($key!=0) { //最后一个
		$ary[$key]=$sclass_list;	
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
  
  public function get_logs($lesson_id,$input) { //获取班级课程日志
	//var_dump($input);
	$class_id  = $input["sclass"];
	$course_id = $input["course"];
	
	$sql="select * from v_course_logs where sclass=".$class_id;
	if ($lesson_id>0) { //课堂对应
		$sql.=" and lesson =".$lesson_id;
	} else {
		$course_id=isset($input["course"])?$input["course"]:0;
		if($course_id==0) { //获取课程对应日志
			$sql.=" and course =".$course_id;
		} else { //获取课程日志
		}	
	}
	  
	$sql.=" order by ltime desc";
	$query = $this->db->query($sql);
	
//	if ($query->num_rows()>0)
	$data["list"] = $query->result_array();

	// 课程	
	$data["course_id"]  = $course_id;
//	$data["course_name"]= "课程";

	//相关章节
	$data["lesson_id"]  = $lesson_id;
	$data["lesson_name"]= $input["lesson_name"];

	//相关班级
	$data["class_id"]  = $class_id;
	$data["class_name"]=  $input["class_name"];

	return $data;
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
		'edit_at' => time()/60
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

	  // 更新相关课堂
	  $sql="update lessons set update_at=".(time()/60)." where module=".$id;
	  $this->db->query($sql);
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
		'edit_at' => time()/60
		);

    $this->db->where('id', $id);
    $this->db->update($table, $data);
	
	
	// 更新相关课堂
	$sql="update lessons set update_at=".(time()/60)." where module=".$id;
	$this->db->query($sql);
	
	
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
	  $lesson_id-$this->db->insert_id;
    } else {
      $this->db->where('id', $lesson_id);
      $this->db->update($table, $data); 
    }
	
	$sql="select course from cmodules where id=$id";
	$query = $this->db->query($sql);
	$course_id =($query->num_rows() > 0)?$query->row()->course:0;
	$content="修改了课堂状态";
	
    $log = array(
		'course'	=> $course_id,
		'sclass' 	=> $item["class_id"],
		'lesson'  	=> $lesson_id,
		'ltype'  	=> 1,
		'content'	=> $content,
		'ltime'		=> time(),
	    );

//	var_dump($log);
	$this->save_log($log);	
	
    return TRUE;
  }
  
    // 保存日志
  public function save_log($log) { //模块id    
    $table="clogs";
    $this->db->insert($table, $log); 

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