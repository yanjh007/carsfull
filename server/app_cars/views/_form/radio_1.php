<div class="form-group">
  <label ><?php echo  $title ?></label>
  <?php for ($i=0;$i < count($list);$i++): $kv= explode(":",$list[$i]); ?>      
    <label class="radio-inline">
      <input type="radio"
             name="<?=$name ?>"
            id="<?=$name.$i ?>"
            value="<?=$kv[0] ?>"
            <?php if ($select==$kv[0]) echo "checked";?> >
            <?=$kv[1] ?>
    </label>
  <?php endfor ?>
</div>
