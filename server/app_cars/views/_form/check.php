<?php $str_list=",".$value."," ?>
<div class="form-group">
<?php if($ftype==0): ?>
  <label class="col-sm-1 control-label"><?php echo $title ?></label>
  <div class="col-sm-6">
    <?php $i=0; foreach ($list as $k=>$v):?>    
      <label class="checkbox-inline">
        <input type="checkbox" name="<?php echo $name ?>"  id="<?php echo $name ?>" value="<?php echo $k ?>"
        <?php echo (strpos($str_list,$k)!==FALSE?" checked>":">").$v; ?>                                                                                            
      </label>
    <?php $i++; endforeach ?>
  </div>
 
<?php elseif($ftype==1): ?>
  <label ><?php echo $title ?></label><br>
    <?php $i=0; foreach ($list as $k=>$v):?>
      <div class="checkbox"><label class="checkbox">
      <input type="checkbox" name="<?php echo $name ?>"  id="<?php echo $name ?>" value="<?php echo $k ?>"
          <?php echo (strpos($str_list,$k)!==FALSE?" checked>":">").$v; ?>                                                                                            
      </label></div>
    <?php $i++; endforeach ?>

<?php endif ?>
</div>



