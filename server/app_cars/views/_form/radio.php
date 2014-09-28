<div class="form-group">
<?php if($ftype==0): ?>
  <label class="col-sm-1 control-label"><?= $title ?></label>
  <div class="col-sm-6">
    <?php $i=0; foreach ($list as $k=>$v):?>      
      <label class="radio-inline">
      <input type="radio" name="<?php echo $name ?>"  id="<?php echo $name.$i ?>" value="<?php echo $k ?>"
            <?php echo ($select==$k?" checked>":">").$v; ?>
      </label>
    <?php $i++; endforeach ?>
  </div>
 
<?php else: ?>
  <label ><?php echo $title ?></label><br>
    <?php $i=0; foreach ($list as $k=>$v):?>      
      <label class="radio-inline">
      <input type="radio" name="<?php echo $name ?>"  id="<?php echo $name.$i ?>" value="<?php echo $k ?>"
            <?php echo ($select==$k?" checked>":">").$v; ?>
      </label>
    <?php $i++; endforeach ?>


<?php endif ?>
</div>
