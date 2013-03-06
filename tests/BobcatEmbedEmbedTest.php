<?php

require_once("lib/BobcatEmbedEmbed.php");

class BobcatEmbedEmbedTest extends PHPUnit_Framework_TestCase {

  public $bobcat_embed_embed;

  public function setup() {
    $this->bobcat_embed_embed = new Bobcat_Embed_Embed();
    $this->bobcat_embed_embed->init();
  }

  public function testDefaultFormat() {
    $this->assertInstanceOf('Bobcat_Embed_Embed', $this->bobcat_embed_embed);
  } 


}