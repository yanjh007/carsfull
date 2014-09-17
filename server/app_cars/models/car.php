<?php
class Car extends CI_Model {
  const SQLQUERY    = 'SELECT id,carnumber,manufacturer,brand,descp FROM cars ';
  const TABLE_NAME  = 'cars';	
  
  public function __construct() {
    $this->load->database();
  }

  public function search($keyword = FALSE) {
    $sql=self::SQLQUERY;
    if ($keyword) {
      $sql=$sql." where carnumber like '%".$keyword."%' or manufacturer like '%".$keyword."%' or brand like '%".$keyword."%'";
    }
    
    $sql= $sql." order by edit_at desc limit 20";

    $query = $this->db->query($sql);
    return $query->result_array();
  }

  public function get_one($id){
    $query = $this->db->query(self::SQLQUERY." where id=?",$id);
    return $query->row_array();
  }
  
  public function save($item) {
    $data = array(
			'carnumber' => $item["carnumber"],
			'descp' => $item["descp"],
          );
    
	if (isset($item["item_id"]) ) { // insert
        $this->db->where('id', $item["item_id"]);
        $this->db->update(self::TABLE_NAME, $data); 
	} else {
        $this->db->insert(self::TABLE_NAME, $data); 
	}
    return TRUE;
  }
  
  public function remove($id) {
    $this->db->where('id', $id);
    $this->db->delete(self::TABLE_NAME); 
    return TRUE;
  }

  // 网络接口用方法
  function get_cars_list($clientid) {
    $sql= "select cid,carnumber,manufacturer,brand,descp,framenumber from v_carsofuser where uid =".$clientid;

    $query = $this->db->query($sql);
    return  $query->result_array(); 
  }
  
  function if_cars_list() {
    // 版本
    $clientid= $this->input->get_post("U");
    $version = $this->input->get_post("V");
    
    if (!$version) $version=0;
      
    $this->load->model("zmversion");
    $version2 = $this->zmversion->check_version("client_cars_".$clientid,$version);
    if ($version2>0) { 
      $content["version"] = $version2;
      $content["cars"] = $this->get_cars_list($clientid);
  
      $data["content"] = json_encode($content);      
    } else { //无更高版本
      $data["result"]="NULL"; 
    }
    return $data;
  }
  
  function if_cars_update() {
    $clientid= $this->input->get_post("U");
    
    // 车辆信息版本
    $this->load->model("zmversion");
    $version  = $this->input->post("V");
    $version2 = $this->zmversion->check_version("client_cars_".$clientid,$version);
    
    if($version2>0) {
      $data["result"]="FALSE"; //数据交付格式错误
      $data["content"] = json_encode(array("status"=>51,"error"=>"服务端有更新版本","version"=>$version2));
      return $data;
    } 
    
    // 车辆信息处理
    $cars =$this->input->post("C");
    if ($cars) {
      $ary=json_decode($cars,TRUE);
      if ($ary) {
	$sql= "select cid,carnumber from v_carsofuser where uid =".$clientid;

	$query = $this->db->query($sql);
	if ($query->num_rows() > 0) {
	    $ary_cars = $query->result_array();
	} else {
	    $ary_cars=NULL;  
	}
	
	$strupdate=""; $stradd="";
	$strdel="";$slistdel="";
	foreach ($ary as $item) {
	  $carnumber=$item["carnumber"];

	  if ($item["status"]==3) { //删除列表
	    $slistdel.= ($slistdel=="")?$carnumber:",".$carnumber;
	    $strdel  .= ($strdel=="")?$item["carid"]:",".$item["carid"];
	    continue;
	  }

	  $carid=0;
	  if ($ary_cars) foreach ($ary_cars as $car) {
	      if ($carnumber==$car["carnumber"]) {
		$carid = $car["cid"];
		break;
	      }
	  }
	  
	  $data = array(
		  'framenumber'  => $item["framenumber"],
		  'manufacturer' => $item["manufacturer"],
		  'brand' => $item["brand"],
		  );
	  $arr_add=array();
	  if ($carid==0) { //增加
	      $data["carnumber"]=$carnumber;
              $this->db->insert(self::TABLE_NAME, $data);
	      $carid = $this->db->insert_id();
	      
	      // 客户端连接
	      $this->load->model("link");	      
	      $this->link->link(Link::TYPE_CLIENT_CARS,$clientid,"",$carid,$carnumber);
	    
	      $stradd.= ($stradd=="")?$carnumber:",".$carnumber;
	      $arr_add[$carnumber]=$carid;
	  } else { //修改
	      $this->db->where('id', $carid);
	      $this->db->update(self::TABLE_NAME, $data);
	      
	      $strupdate.= ($strupdate=="")?$carnumber:",".$carnumber;
	  }
	}
	
	// 删除的项目
	if ($strdel!="") {
	    $this->db->where(" id in (".$strdel.")",NULL,FALSE);
	    $this->db->delete(self::TABLE_NAME);
	 
	    $this->db->where(" ltype=1 and lid=".$clientid." and rid in (".$strdel.")",NULL,FALSE);
	    $this->db->delete("links");
	}

	// 设置版本
	$this->load->model("zmversion");	
	$version2 = $this->zmversion->set_version("client_cars_".$clientid);
	
	// 返回结果
	$data["content"] = json_encode(array("version"=>$version2,"updated"=>$strupdate,"added"=>$arr_add,"deled"=>$slistdel));		
      }
    } else {
	$data["result"]="FALSE"; //数据交付格式错误
	$data["content"] = json_encode(array("status"=>21,"error"=>"数据为空"));	
    }
    
    return $data;
  }
}