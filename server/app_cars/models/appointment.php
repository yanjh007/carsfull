<?php
Class Appointment extends CI_Model {
  const SQLQUERY  = 'SELECT id,userid,rtime,ptime,status FROM appointments ';
  
  const STD_SELECT = "SELECT a.id id,a.acode,userid,rtime,ptime,status,c.carnumber car,c.shop_code,s.name shop_name
	FROM appointments a 
	left join car_aptms c on a.acode=c.acode
	left join shops s on c.shop_code=s.scode";

  const TABLE_NAME  = "appointments";
  const TABLE_NAME2 = "car_aptms";
  const TABLE_NAME3 = "shops";
  
  public function __construct() {
    $this->load->database();
  }
  
  public function search($keyword = FALSE) {
    $sql=self::STD_SELECT;
    if ($keyword) {
      //$sql=$sql." where name like '%".$keyword."%' ";
    }
    
	$sql=$sql." order by rtime desc";
    $query = $this->db->query($sql);
    return $query->result_array();
  }
  
  // 筛选
  public function filter($filter) {
    $sql=self::STD_SELECT;
    if ($filter==0) { //全部
	  $sql .= " order by rtime desc";
    } else if ($filter==1) {
	  $sql .= " where status=1 order by rtime desc";
	} else if ($filter==2) {
	  $sql .= " where status=2 order by edit_at desc";
	} else if ($filter==3) {
	  $sql .= " where status=3 order by edit_at desc";
	}
    
    $query = $this->db->query($sql);
    return $query->result_array();
  }

  public function save($item) {
    //var_dump($tasktype);    
    $data = array(
           'client'     => $item["client"],
           'car'      => $item["car"],
           'duration1' => $item["atime"],
          );
    
	if (isset($item["item_id"]) ) { // insert
        $this->db->where('id', $item["item_id"]);
        $this->db->update('appoiontments', $data); 
	} else {
        $this->db->insert('appoiontments', $data); 
	}
    return TRUE;
  }
  
  public function get_one($id){
    $query = $this->db->query(self::SQLQUERY." where id=?",$id);
    return $query->row_array();
  }
 
  public function remove($id) {
    $this->db->where('id', $id);
    $this->db->delete('appoiontments');
	
	//$this->load->model('link');
    //$this->db->where('ltype',Link::TYPE_TASKGROUP_TASK);
    //$this->db->where('rid', $id);
    //$this->db->delete('links');
    return TRUE;
  }
  
  public function confirm($id,$status,$note="") { //预约确认

    $this->db->where('id',$id);
    $this->db->update(self::TABLE_NAME,array("status"=>$status,"descp"=>$note,"edit_at"=>date("Y-m-d H:i:s")));

    return TRUE;
  }
  
  public function onSubmit($json,$client_id) {
    $apmts=json_decode($json,TRUE); //确认转化为数组
    
	$list0="";
    // 插入或更新数据
    if ($apmts) foreach ($apmts as $item) {
      $acode = $item["acode"];
 
      $data1 = array(
		'status'    => 1,
		'userid'    => $client_id, //用户
		'rtime'     => date("Y-m-d H:i:s"), //计划时间
		'ptime'     => $item["plan_at"], //计划时间
      );
      
      $data2 = array (
		'client'    => $client_id,
		'carnumber' => $item["car"],
		'shop_code' => $item["shop"],
      );

      $query = $this->db->query("select 1 from ".self::TABLE_NAME." where acode=? limit 1",$acode);
      if ($query->num_rows()>0) {
		
        $this->db->where('acode', $acode);
		
        $this->db->update(self::TABLE_NAME,  $data1);
        $this->db->update(self::TABLE_NAME2, $data2);		
      } else {
		$data1["acode"]=$acode;
		$this->db->insert(self::TABLE_NAME, $data1); 

		$data2["acode"]=$acode;
		$this->db->insert(self::TABLE_NAME2, $data2); 
      }
	  
	  $list0.=strlen($list0)>0?",".$acode:$acode;
    }
    
	// approved list
	$sql = "select acode,descp from ".self::TABLE_NAME." where atype=0 and status=? and userid= ?";
	
    $list1="";
    $query = $this->db->query($sql,array(2,$client_id));
    if ($query->num_rows() > 0) foreach ($query->result() as $row) {
	  if (strlen($list1)>0) $list1 .="#";
	  $list1.= $row->acode."#".$row->descp;
    }
    
	// refaused list
    $list2="";
    $query = $this->db->query($sql,array(3,$client_id));
    if ($query->num_rows() > 0) foreach ($query->result() as $row) {
	  if (strlen($list2)>0) $list2 .="#";
	  $list2.= $row->acode."#".$row->descp;
    }
    
    $data["content"] = json_encode(array("received"=>$list0,"approved"=>$list1,"refused"=>$list2));
    return $data;
  } 
}
?>
