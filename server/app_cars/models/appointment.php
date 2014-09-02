<?php
Class Appointment extends CI_Model {
  const SQLQUERY  = 'SELECT id,client,car,atime,status FROM appointments ';
  const TABLENAME  = 'appointments';
  const TABLENAME2 = 'car_aptms';
  
  public function __construct() {
    $this->load->database();
  }
  
  public function search($keyword = FALSE) {
    $sql=self::SQLQUERY;
    if ($keyword) {
      //$sql=$sql." where name like '%".$keyword."%' ";
    }
    
    //$sql= $sql." order by role desc";

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
  
  public function onSubmit($json,$client_id) {
    $apmts=json_decode($json,TRUE); //确认转化为数组
    $list2="";

    // 插入或更新数据
    foreach ($apmts as $item) {
      $acode = $item["acode"];
      
      $query = $this->db->query(self::SQLQUERY." where acode=? limit 1",$acode);

      $data1 = array(
		'status'    => 1,
		'rtime'     => $item["plan_at"], //提交时间
		'ptime'     => $item["plan_at"], //计划时间
      );
      
      $data2 = array (
		'client'    => $client_id,
		'carnumber' => $item["car"],
      );

      if ($query->num_rows()>0) {
        $this->db->where('acode', $acode);
		
        $this->db->update(self::TABLENAME,  $data1);
        $this->db->update(self::TABLENAME2, $data2);		
      } else {
		$data1["acode"]=$acode;
		$this->db->insert(self::TABLENAME, $data1); 

		$data2["acode"]=$acode;
		$this->db->insert(self::TABLENAME2, $data2); 
      }
    }
    
    $list1=""; $i=0;
    $query = $this->db->query(self::SQLQUERY." where status=?",2);
    if ($query->num_rows() > 0) {
      foreach ($query->result() as $row) {
	if ($i>0) $list1.=",";
	$list1.= $row->acode;
      }
    }
    
    $list2=""; $i=0;
    $query = $this->db->query(self::SQLQUERY." where status=?",4);
    if ($query->num_rows() > 0) {
      foreach ($query->result() as $row) {
		if ($i>0) $list2.=",";
		$list2.= $row->acode;
      }
    }
    
    
    $data["content"] = json_encode(array("list_confirm"=>$list1,"list_refuse"=>$list2));
    return $data;
  }
  
 
}
?>
