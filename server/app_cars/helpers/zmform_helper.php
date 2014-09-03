<?php
/*
 * URL helpers, this file extends
 * the current URL helper that
 * CodeIgniter includes.
*/

/**
 * asset_url
 *
 * This function OVERRIDES the current
 * CodeIgniter base_url function to support
 * CDN'ized content.
 */

function zm_form_open($path,$option=array("role"=>"form"))
{
   echo form_open($path,$option);
}

function zm_form_hidden($name,$value)
{
   echo form_hidden($name, $value);
}
 
function zm_form_select($ftype,$title,$name,$list,$select="")
{
   $CI=&get_instance();
   $form_data["title"]    = $title;
   $form_data["name"]     = $name;
   $form_data["list"]     = $list;
   $form_data["select"]   = $select;
   $CI->load->view('_form/select_'.$ftype,$form_data);   
}


function zm_form_radio($ftype,$title,$name,$list,$select="")
{
   $CI=&get_instance();
   $form_data["title"]    = $title;
   $form_data["name"]     = $name;
   $form_data["list"]     = $list;
   $form_data["select"]   = $select;

   $CI->load->view('_form/radio_'.$ftype,$form_data);   
}

function zm_form_check($title,$name,$checked="")
{
   $CI=&get_instance();
   $form_data["title"]    = $title;
   $form_data["name"]     = $name;
   $form_data["checked"]   = $checked;

   $CI->load->view('_form/check_0',$form_data);   
}

function zm_form_input($ftype,$title,$name,$value="")
{  
   $CI=&get_instance();
   $form_data["title"] = $title;
   $form_data["name"]  = $name;
   $form_data["value"] = $value;

   $CI->load->view('_form/input_'.$ftype,$form_data);   
}

function zm_form_textarea($ftype,$title,$name,$value="")
{   
   $CI=&get_instance();
   $form_data["title"] = $title;
   $form_data["name"]  = $name;
   $form_data["value"] = $value;

   $CI->load->view('_form/textarea_'.$ftype,$form_data);   
}

function zm_btn_back($address)
{
   $click="document.location.href='".base_url($address)."'";
   echo "<button class='btn btn-default' type='button' id='btn_back' onclick=".$click.">返 回</button>&nbsp&nbsp";   
}

function zm_btn_submit($title,$option="")
{
   echo "<button type='submit' class='btn btn-primary'>".$title."</button>&nbsp&nbsp";
}

function zm_btn_delete($title,$onclick,$option="")
{
   echo "<button type='button' class='btn btn-danger' onclick='".$onclick."' >".$title."</button>&nbsp&nbsp";
}

function zm_dlg_delete($form_data)
{
   $CI=&get_instance();
   $CI->load->view('_form/dlg_delete',$form_data);  
}

function zm_btn_input($title,$onclick,$option="")
{
   echo "<button type='button' class='btn btn-danger' onclick='".$onclick."' >".$title."</button>&nbsp&nbsp";
}

function zm_dlg_input($form_data)
{
   $CI=&get_instance();
   $CI->load->view('_form/dlg_input',$form_data);  
}


