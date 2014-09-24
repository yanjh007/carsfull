<?php
class Sclass extends CI_Model {
  const TABLE_NAME = 'sclasses';
  const STD_SQL_QUERY  = 'SELECT id,scode,name,address,contact,gyear,utype FROM sclasses ';
  
  public function __construct() {
    $this->load->database();
  }

  public function search($keyword = FALSE) {
    $sql= self::STD_SQL_QUERY;
    if ($keyword) {
      $sql=$sql." where name like '%".$keyword."%' ";
    }
    
    $sql= $sql." order by scode limit 20";

    $query = $this->db->query($sql);
    return $query->result_array();
  }

  //学校列表
  public function get_schools($id=0) {
    if ($id==0) {
      $sql= self::STD_SQL_QUERY." where utype=0 order by scode";
      $query = $this->db->query($sql);
      return $query->result_array();
    } else {
      $sql= self::STD_SQL_QUERY." where id=".$id ;
      $query = $this->db->query($sql);
      return $query->row_array();
    }
  }

  //班级列表
  public function get_sclass($pid,$id=0){
    if ($id==0) { //输入列表
      if ($pid==0) {
	$sql= self::STD_SQL_QUERY." where utype=2 order by scode,gyear";
      } else {
	$sql= self::STD_SQL_QUERY." where utype=2 and pid =".$pid." order by gyear";
      }
      
      $query = $this->db->query($sql);
      return $query->result_array();
    } else {
      $sql= self::STD_SQL_QUERY." where id=".$id ;
      $query = $this->db->query($sql);
      return $query->row_array();
    }
  }
  
  public function save($item,$id,$utype) {
    $data = array(
		  'scode'   => $item["scode"],
		  'name'    => $item["name"],
		  'contact' => $item["contact"],
		  'address' => $item["address"],
		  'utype' => $utype,
		   );
    if ( $utype==2 ) {
      $data["gyear"]=$item["gyear"];
    }
    
    if ($id==0) { // insert
      $this->db->insert(self::TABLE_NAME, $data);
      return $this->db->insert_id();
    } else {
      $this->db->where('id', $id);
      $this->db->update(self::TABLE_NAME, $data);
      return $id;
    }
	
  }
  
  public function remove($item_id) {
    $this->db->where('id', $item_id);
    $this->db->delete(self::TABLE_NAME); 

    return TRUE;
  }
  
  // 选择用列表
  public function select_list() {
    $sql="select id,scode,name from shops order by scode";
    $query = $this->db->query($sql);
    return $query->result_array();
  }
  
  public function link($shop) {
    $car_number = $shop["carnumber"];
	if (isset($car_number) ) {
      $query = $this->db->query("SELECT id FROM cars where carnumber ='".$car_number."' limit 1");
      if($query ->num_rows() > 0) {
        $car_id = $query->row()->id;
        
        $query = $this->db->query("SELECT 1 FROM links where ltype=1 and lid = ".$shop["shop_id"]." and rid=".$car_id." limit 1");  
        if($query -> num_rows() == 0) {
          $data = array(
                 'ltype'  => '1',
                 'lid'    => $shop["shop_id"],
                 'lname'  => $shop["shop_name"],
                 'rid'    => $car_id,
                 'rname'  => $car_number,
                );
          $this->db->insert('links', $data); 
          return TRUE;
        }         
      }
	}
    return NULL;
  }
  
  // 依据时间获取店铺列表接口
  public function if_shops() {
    $version = $this->input->get_post('V');
    $this->load->model("zmversion");
    $v2 = $this->zmversion->checkVersion("shop_version",$version?$version:0);
    
    if ($v2==0) {
      $data["result"] = "NULL";
    } else {
      $query = $this->db->query(self::SQLQUERY." order by scode");	  
      if ($query->num_rows() > 0) {
	    $data["content"] = json_encode(array("version"=>$v2,"shops"=>($query->result())));
      } else {
	    $data["result"] = "NULL";
      }	  
    }

    return $data;
  }
  
}