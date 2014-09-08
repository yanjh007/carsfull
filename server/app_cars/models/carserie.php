<?php
class Carserie extends CI_Model {
  const STD_QUERY  = "SELECT id,name,manufacturer,brand,ctype,tags,trans_list,color_list,engine_list,serie_url,descp FROM carseries ";
  const TABLE_NAME = "carseries";
  
  public function __construct() {
    $this->load->database();
  }

  public function search($keyword = FALSE) {
    $sql =  self::STD_QUERY;
    if ($keyword) {
      $sql=$sql." where mcode like '%".$keyword."%' or manufacturer like '%".$keyword."%' or brand like '%".$keyword."%'";
    }
    
    $sql= $sql." order by manufacturer,version desc limit 20";

    $query = $this->db->query($sql);
    return $query->result_array();
  }

  
  public function search_tag($tag = FALSE) {
    $sql =  self::STD_QUERY;
    if ($tag) {
      $sql=$sql." where tags like '%".$tag."%'";
    }
    
    $sql= $sql." order by tags";	
	
    $query = $this->db->query($sql);

    return $query->result_array();
  }
  
  public function get_one($id){
    $query = $this->db->query(self::STD_QUERY." where id=?",$id);
    return $query->row_array();
  }
  
  public function save($item,$id) {
    $data = array(
			  'manufacturer'=> $item["manufacturer"],
			  'brand' 		=> $item["brand"],
			  'ctype'  		=> $item["ctype"],
			  'tags'   		=> $item["tags"],
			  'color_list'   	=> $item["color_list"],
			  'trans_list'   	=> $item["trans_list"],
			  'engine_list'   	=> $item["engine_list"],
			  'descp'   		=> $item["descp"],
			  'serie_url'   		=> $item["serie_url"],
			);
    
	if ($id>0) { // insert
        $this->db->where('id', $id);
        $this->db->update(self::TABLE_NAME, $data); 
	} else {
        $this->db->insert(self::TABLE_NAME, $data); 
	}
    return TRUE;
  }
  
  public function remove($item_id) {
    $this->db->where('id', $item_id);
    $this->db->delete(self::TABLE_NAME); 
    return TRUE;
  }
  
  public function if_tag($tag) {
    $sql="select id,manufacturer,brand,tags from ".self::TABLE_NAME." where tags like '%".$tag."%' order by manufacturer";	
	
    $query = $this->db->query($sql);

	if ($query->num_rows() > 0) {
	  $data["content"] = json_encode($query->result_array());
	} else {
	  $data["result"] = "NULL";
	}	

    return $data;  
  }

}