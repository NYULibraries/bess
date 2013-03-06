<?php

require_once("lib/BobcatEmbedGenerate.php");

class BobcatEmbedGenerateTest extends PHPUnit_Framework_TestCase {


  public $bobcat_embed_generate;

  public function setup() {
    $this->bobcat_embed_generate = new Bobcat_Embed_Generate();
    $this->bobcat_embed_generate->init();
  }

  public function testDefaultFormat() {
    $this->assertInstanceOf('Bobcat_Embed_Generate', $this->bobcat_embed_generate);
  } 


}