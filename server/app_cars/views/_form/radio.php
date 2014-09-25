<div class="form-group">
<?php if($ftype==0): ?>
  <label class="col-sm-1 control-label"><?= $title ?></label>
  <div class="col-sm-6">
    <?php foreach ($list as $item):?>      
      <label class="radio-inline">
      <input type="radio" name="<?php echo $name ?>"  id="<?php echo $name.$i ?>" value="<?php echo $item["id"] ?>"
            <?php echo ($select==$item["id"])?" checked>":">".$item["value"]; ?>;
      </label>
    <?php endforeach ?>
  </div>
 
<?php else: ?>
  <label ><?php echo $title ?></label><br>
  <?php $i=0; foreach ($list as $item):?>      
    <label class="radio-inline">
      <input type="radio" name="<?php echo $name ?>"  id="<?php echo $name ?>" value="<?php echo $item["id"] ?>"
            <?php echo (($select==$item["id"])?" checked>":">").$item["value"]; ?>
    </label>
  <?php $i++; endforeach ?>

<?php endif ?>
</div>
