<?php
    $MODULE_PATH="courses/";
?>
<div class="container">
    <div class="page-header">
      <h1>答题批覆 <small></small></h1>
    </div>
    
    <div class="row">
    <div class="col-md-8">
    <div class="panel panel-default">
        <?php
            $uid    = $item["uid"];
            $qorder = $item["qorder"];
            $mid    = $item["mid"];
            
            $content=$item["content"];
            $json=json_decode($content,true);
            
            $content=$json["content"];
            $qtype=0;

            foreach ($content as $citem) {
                if ($qorder== $citem["qorder"]) {
                    $qtype=$citem["qtype"];
                    $str=$citem["content"];
                    break;
                }
            }
            $list=explode("\n\n\n",$str);
        ?>
        <!-- Default panel contents -->
        <div class="panel-heading">题目信息 (<?php echo $qtype ?>)</div>
        <div class="panel-body">
            <?php
            echo $list[0]."<br>";
            
            if (isset($list[1]) && strlen($list[1])>0) {
                $olist=explode("\n",$list[1]);
                //echo "选项: <br>";
                $clist=array("A","B","C","D","E","F","G","H","I");
                $i=0;
                $astr="";
                foreach ($olist as $oitem) {
                    $postion1 = strpos($oitem, "✓");
                    if ($postion1!==FALSE) {
                        $oitem = substr($oitem, $postion1+strlen("✓"));
                        $astr.=$clist[$i];
                    }
                    echo $clist[$i].". ".$oitem."<br>";
                    $i++;
                }
                
                echo "参考答案: ".$astr;
            }
            echo "<hr>";            
            echo "学员代码: ".$item["snumber"]."<br>";
            echo "学员姓名: ".$item["name"]."<br>";
            echo "学员答案: ".$item["answer"]."<br>";
            echo "结果状态: ".$item["status"]."<br>";
            echo "得分: ".$item["score"]."<br>";
            ?>
        </div>
        
    </div>
    <?php echo zm_btn_back($MODULE_PATH.$module_id."/report?sclass=".$sclass_id); ?>
    </div>
    
    <div class="col-md-4">
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">批复</div>
        <div class="panel-body">
            <?php
                zm_form_open (1,$MODULE_PATH.$module_id."/save_review");
                zm_form_hidden("sclass",$sclass_id);
                zm_form_hidden("uid",$uid);
                zm_form_hidden("qorder",$qorder);
                zm_form_hidden("mid",$mid);
                zm_form_input(1,"修正得分","score",   $item["score"]);
                
                $rnote=explode("\n",$item["rnote"]);
                zm_form_textarea(1,"批复说明","descp", $rnote[0]);
            ?>
            
            <div class="form-group">
                <?php
                    zm_btn_submit("保存");
                    zm_btn_submit("保存->下一题");
                ?>
               
            </div>
          </form>
        </div>
    </div></div></div>

</div>