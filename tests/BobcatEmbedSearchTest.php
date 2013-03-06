<?php

require_once("lib/BobcatEmbedSearch.php");

class BobcatEmbedSearchTest extends PHPUnit_Framework_TestCase {

  public $bobcat_embed_search;

  public function setup() {
    $this->bobcat_embed_search = new Bobcat_Embed_Search();
    $this->bobcat_embed_search->init();
  }

  public function testDefaultFormat() {
    $this->assertInstanceOf('Bobcat_Embed_Search', $this->bobcat_embed_search);
  } 


}