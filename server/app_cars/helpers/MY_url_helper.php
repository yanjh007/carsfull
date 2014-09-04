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
function asset_url($uri = null)
{
   $CI =& get_instance();

   $cdn = $CI->config->item('asset_url');
   if (!empty($cdn))
      return $cdn . $uri;

   return $CI->config->base_url($uri);
}

/*
 * is_active
 * Allows a string input that is
 * delimited with "/". If the current
 * params contain what is currently
 * being viewed, it will return true
 *
 * This function is order sensitive.
 * If the page is /view/lab/1 and you put
 * lab/view, this will return false. 
 *
 * @author sjlu
 */
function is_active($input_params = "")
{
   // uri_string is a CodeIgniter function
   $uri_string = uri_string();

   // direct matching, faster than looping.
   if ($uri_string == $input_params)
      return true;
      
   $uri_params = preg_split("/\//", $uri_string);
   $input_params = preg_split("/\//", $input_params);

   $prev_key = -1;
   foreach ($input_params as $param)
   {
      $curr_key = array_search($param, $uri_params);

      // if it doesn't exist, return null
      if ($curr_key === FALSE)
         return false;

      // this makes us order sensitive
      if ($curr_key < $prev_key)
         return false;

      $prev_key = $curr_key;
   }

   return true;
}

function nav_menu_item($title,$path)
{
   if ($title=="") {
      echo "<li class='divider'></li>";
   } else {
      echo "<li>".anchor(base_url($path),$title)."</li>";  
   }
}

function link_to_edit($path)
{
   echo anchor($path,"编辑");
}

function link_to_jdelete($onclick)
{
   echo "<a href='#' onclick='".$onclick."'>删除</a>";
}

function link_to_jinput($onclick,$title)
{
   echo "<a href='javascript:void(0);' onclick='".$onclick."'>".$title."</a>";
}


