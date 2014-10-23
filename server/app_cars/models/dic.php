<?php
class Dic extends CI_Model {
  const DIC_TYPE_ALL		= 0;
  
  const DIC_COURSE_CATA     = 9; //课程科目
  const DIC_TYPE_COURSE		= 10; //课程类型
  const DIC_LESSON_STATUS	= 11; //课堂状态
  
  const DIC_TYPE_QUESTION	= 12; //课堂状态
  const DIC_TYPE_CONTENT	= 13; //课程类型

  const DIC_NUMBER_START	= 0;
  const DIC_NUMBER_END    	= 1000;
  
  const TABLE_NAME = 'zm_dic';
  const STD_SQL_QUERY  = 'SELECT id,dtype,did,dcode,name,descp FROM ';
  const SQL_RANGE  = ' and did>0 and did<1000 ';
  const SQL_IN    = ' dtype in (9,10,11,12,13) ';
  
  public function __construct() {
    $this->load->database();
  }

  public function get_list($dtype=self::DIC_TYPE_ALL) {
    $sql=self::STD_SQL_QUERY.self::TABLE_NAME;
    if($dtype==self::DIC_TYPE_ALL) {
      $sql .= " where ".self::SQL_IN." order by dtype,did " ;	  
    } else {
      $sql .= " where dtype=".$dtype.self::SQL_RANGE." order by did " ;
    }
    $query = $this->db->query($sql);
    return $query->result_array();
  }
  
  public function get_slist($gtype,$dtype) { //gtype获取方式 0-idname 1-codename dtype字典类型
	$ary=array();
	if ($dtype==0) {
	  $sql="select dtype,name from ".self::TABLE_NAME." where  ".self::SQL_IN." and did=0 order by did ";
	  $query = $this->db->query($sql);
	  
	  if ($query->num_rows()>0) foreach ($query->result() as $row) {
		$ary[$row->dtype]=$row->name;
		//array_push($ary,$row->dtype);
		//array_push($ary,$row->name);
	  }
	} else {
	  $sql="select did,dcode,name from ".self::TABLE_NAME." where dtype=".$dtype.self::SQL_RANGE." order by did ";
	  $query = $this->db->query($sql);

	  if ($query->num_rows()>0) foreach ($query->result() as $row) {
		if ($gtype==0) { //didname
		  //$ary[]=$row->did;
		  $ary[$row->did] = $row->name;
		} else { // codename
		  //$ary[]=$row->dcode;
		  $ary[$row->dcode] = $row->name;
		}
		//$ary[]=$row->name;
	  }
	}

    return $ary;
  }
  
  public function get_codename_list($dtype) {
    $sql= "select dcode,name from ".self::TABLE_NAME." where dtype=".$dtype.self::SQL_RANGE." order by did " ;

    $query = $this->db->query($sql);
    $ary=array();
    if ($query->num_rows()>0) foreach ($query->result() as $row) {
		$ary[$row->dcode]=$row->name;
    }
    return $ary;
  }

  public function get_dic_list($dtype) {
    $sql= "select did id,name value from ".self::TABLE_NAME." where dtype=".$dtype." and did>0 and did<100 order by did " ;

    $query = $this->db->query($sql);
    $ary_dic=array();
    if ($query->num_rows()>0) foreach($query->result() as $row) {
      $ary_dic[$row->id]=$row->value;
    }
    
    return $ary_dic;
  }

  public function save($id,$item){
	$pos=$item["did"];
	$dtype=$item["dtype"];
	
    if ($pos=="" || $pos==self::DIC_NUMBER_END) { //在后部插入
      $sql="select did from ".self::TABLE_NAME." where dtype=".$dtype." and did<".self::DIC_NUMBER_END." order by did desc limit 1";
      $query = $this->db->query($sql);
      $did = $query->row()->did+1;
    } else { 
      $sql="UPDATE ".self::TABLE_NAME." set did=did+1 where dtype=".$dtype." and did>=".$pos." and did<".self::DIC_NUMBER_END;
      $this->db->query($sql);
      
      $did=$pos;
    }
    
    $data = array(
       'dtype' => $dtype,
       'did'   => $did,
       'name'  => $item["name"],
       'dcode' => $item["dcode"],
       'descp' => $item["descp"],
      );
    $this->db->insert(self::TABLE_NAME, $data);	
  }
  
  public function remove($id) {
    $this->db->where('id', $id);
    $this->db->delete(self::TABLE_NAME); 
    return TRUE;
  }

}