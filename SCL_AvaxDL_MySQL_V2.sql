-- MySQL dump 10.13  Distrib 5.7.19, for Linux (x86_64)
--
-- Host: localhost    Database: SCL_AvaxDL_MySQL_V2
-- ------------------------------------------------------
-- Server version	5.7.19-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Categories`
--

DROP TABLE IF EXISTS `Categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Categories` (
  `CategoryID` char(1) NOT NULL COMMENT 'PK of Categories',
  `CategoryValue` varchar(64) NOT NULL,
  `IsIgnored` char(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`CategoryID`),
  UNIQUE KEY `Categories_PK` (`CategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Categories`
--

LOCK TABLES `Categories` WRITE;
/*!40000 ALTER TABLE `Categories` DISABLE KEYS */;
INSERT INTO `Categories` VALUES ('C','comics','Y'),('E','ebooks','N'),('G','games','Y'),('H','hraphile','Y'),('I','graphics','Y'),('M','music','Y'),('N','newspapers','N'),('S','software','N'),('V','video','N'),('X','girls','Y'),('Z','magazines','N');
/*!40000 ALTER TABLE `Categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ContentSnippets`
--

DROP TABLE IF EXISTS `ContentSnippets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ContentSnippets` (
  `CS_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK of ContentSnippets',
  `PageURL` varchar(150) DEFAULT NULL,
  `WebSiteID` char(1) NOT NULL DEFAULT 'A',
  `RecordSnippet` varchar(3000) DEFAULT NULL,
  `PageSnippet` varchar(15000) DEFAULT NULL,
  `DownloadSnippet` varchar(500) DEFAULT NULL,
  `ScanDate` datetime NOT NULL,
  `PublDate` varchar(64) NOT NULL COMMENT 'Publication date of content (YYYY/MM/DD)',
  `CategoryID` char(1) NOT NULL COMMENT 'Reference to Category Record',
  `LanguageID` smallint(6) NOT NULL DEFAULT '0',
  `PlatformTypeID` char(1) NOT NULL DEFAULT 'N',
  `QP_ID` int(11) DEFAULT NULL COMMENT 'Reference to QueryPages Record',
  PRIMARY KEY (`CS_ID`),
  UNIQUE KEY `ContentSnippets_PK` (`CS_ID`),
  UNIQUE KEY `PageURL` (`PageURL`),
  KEY `FK_R_QP_CS` (`QP_ID`),
  KEY `FK_R_Cat_CS` (`CategoryID`),
  KEY `FK_R_LL_CS` (`LanguageID`),
  KEY `FK_R_PT_CS` (`PlatformTypeID`),
  KEY `FK_R_WS_CS` (`WebSiteID`),
  CONSTRAINT `FK_R_Cat_CS` FOREIGN KEY (`CategoryID`) REFERENCES `Categories` (`CategoryID`),
  CONSTRAINT `FK_R_LL_CS` FOREIGN KEY (`LanguageID`) REFERENCES `Languages` (`LanguageID`),
  CONSTRAINT `FK_R_PT_CS` FOREIGN KEY (`PlatformTypeID`) REFERENCES `LPlatformTypes` (`PlatformTypeID`),
  CONSTRAINT `FK_R_QP_CS` FOREIGN KEY (`QP_ID`) REFERENCES `QueryPages` (`QP_ID`),
  CONSTRAINT `FK_R_WS_CS` FOREIGN KEY (`WebSiteID`) REFERENCES `Websites` (`WebSiteID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ContentSnippets`
--

LOCK TABLES `ContentSnippets` WRITE;
/*!40000 ALTER TABLE `ContentSnippets` DISABLE KEYS */;
INSERT INTO `ContentSnippets` VALUES (1,'/software/givar56004DbrUY.html','A','<div class=\"col-md-12 article\"> <div class=\"row\">  <div class=\"col-lg-12\">   <h1>    <a class=\"title-link\" href=\"/software/givar56004DbrUY.html\">     Downie v3.0.5 Multilingual MacOSX    </a>   </h1>   <div class=\"author visible-lg-inline-block visible-md-inline-block visible-sm-block visible-xs-block\">    <strong>     Posted By:    </strong>    <a href=\"/blogs/Givaraa\">     Givaraa    </a>   </div>   <div class=\"post-date visible-lg-inline-block visible-md-inline-block visible-sm-block visible-xs-block\">    <strong>     Date:    </strong>    23 Oct 2017 08:52:49   </div>   <div class=\"text\">    <div class=\"text-center\">     <a href=\"/software/givar56004DbrUY.html\">      <img alt=\"Downie v3.0.5 Multilingual MacOSX\" class=\"img-responsive\" src=\"https://pxhst.co/avaxhome/74/15/004a1574_medium.png\"/>     </a>    </div>    <br/>    <div class=\"text-center\">     <b>      Downie v3.0.5 Multilingual MacOSX | 30 MB     </b>    </div>    <br/>    Downie - this is the easiest video downloader. It supports over 1,100 popular sites such as YouTube (including 4K video), Vimeo, MetaCafe, iView, Facebook and many others. Choose quality and downloadable file format and enjoy your favorite videos.   </div>  </div> </div> <div class=\"row\">  <div style=\"text-align: right\">   <a class=\"details\" href=\"/software/givar56004DbrUY.html\">    Details   </a>  </div> </div> <div class=\"line\"> </div></div>','<div class=\"col-md-12 article\"> <div class=\"row\">  <div class=\"col-lg-12\">   <h1 class=\"title-link\">    Downie v3.0.5 Multilingual MacOSX   </h1>   <div class=\"author visible-lg-inline-block visible-md-inline-block visible-sm-block visible-xs-block\">    <strong>     Posted By:    </strong>    <a href=\"/blogs/Givaraa\">     Givaraa    </a>   </div>   <div class=\"post-date visible-lg-inline-block visible-md-inline-block visible-sm-block visible-xs-block\">    <strong>     Date:    </strong>    23 Oct 2017 08:52:49   </div>   <div class=\"row\">    <div class=\"col-lg-1\">     <g:plusone>     </g:plusone>    </div>    <div class=\"col-lg-2\">     <div class=\"fb-like\" data-action=\"like\" data-layout=\"button_count\" data-share=\"false\" data-show-faces=\"true\">     </div>    </div>   </div>   <div class=\"text\">    <div class=\"text-center\">     <a href=\"#\" onclick=\"$(\'#imageModal4855156\').modal(); return false;\">      <img alt=\"Downie v3.0.5 Multilingual MacOSX\" class=\"img-responsive\" src=\"https://pxhst.co/avaxhome/74/15/004a1574_medium.png\"/>     </a>    </div>    <div aria-labelledby=\"modalLabel4855156\" class=\"modal fade\" id=\"imageModal4855156\" role=\"dialog\" tabindex=\"-1\">     <div class=\"modal-dialog\" role=\"document\" style=\"width: 70%\">      <div class=\"modal-content\">       <div class=\"text-center\">        <div class=\"modal-header\">         <button aria-label=\"Close\" class=\"close\" data-dismiss=\"modal\" type=\"button\">          <span aria-hidden=\"true\">           Ã—          </span>         </button>         <h4 class=\"modal-title\" id=\"modalLabel4855156\">          Downie v3.0.5 Multilingual MacOSX         </h4>        </div>        <div class=\"modal-body\">         <a href=\"https://pxhst.co/avaxhome/74/15/004a1574.png\" target=\"_blank\">          <img alt=\"Downie v3.0.5 Multilingual MacOSX\" class=\"img-responsive\" src=\"https://pxhst.co/avaxhome/74/15/004a1574.png\"/>         </a>        </div>        <div class=\"modal-footer\">         <div class=\"text-center\">          <button class=\"btn btn-default\" data-dismiss=\"modal\" type=\"button\">           Close          </button>         </div>        </div>       </div>      </div>     </div>    </div>    <br/>    <div class=\"text-center\">     <b>      Downie v3.0.5 Multilingual MacOSX | 30 MB     </b>    </div>    <br/>    Downie - this is the easiest video downloader. It supports over 1,100 popular sites such as YouTube (including 4K video), Vimeo, MetaCafe, iView, Facebook and many others. Choose quality and downloadable file format and enjoy your favorite videos.    <br/>    <br/>    4K video YouTube support - unlike many other YouTube downloaders, Downie supports HD video on YouTube, up to 4K.    <br/>    <br/>    Postprocessing - need your video in MP4 for iTunes? Or want just the audio track? No problem, Downie can handle this for you automatically!    <br/>    <br/>    Supported services: YouTube, Vimeo, trailers.apple.com, CNBC, NHL, LiveLeak, Insanee, Daily Haha, BlipTV, DotSub, Daily Motion, Over Stream, eHow, Devil Ducky, PlayFM, PBS, Vine.Co, MetaCafe, iView, Bofunk, MadiaSilo, MTV, V-Vids, 15min.lt, Break.com, CollegeHumor, eBaum\'s World, eSPN.go.com, NicoVideo.jp, NoiseTrade, On.AOL, Billboard, Cook\'s Illustrated, FunnyOrDie, MLB, Bloomberg, Craftsy, Facebook, Kickstarter, Lynda, NBC News, Rotten Tomatoes, Slashdot, South Park Studios, Video Detective, etc.    <br/>    <b>     <br/>     What\'s New in Downie v3.0    </b>    <br/>    <br/>    New Features    <br/>    -UI Redesign - Most of the UI is completely redesigned, including the app icon.    <br/>    -Menu Bar Control - Ability to control Downie from the menu bar.    <br/>    -Link Filtering - Select the links you want to download in case Downie finds multiple downloads on a single page.    <br/>    -Scheduled Downloads - Schedule delayed download start.    <br/>    -Windowless Mode - Ability to close main window without closing the app.    <br/>    -Simple Mode - Less distracting way to display your downloads.    <br/>    -Download Folder Hierarchy - Options to sort downloaded files by website, playlist and include playlist information in file name.    <br/>    -Automatic Ordering - Option to automatically order the queue by progress or name.    <br/>    -Automatic Clearing - Option to automatically remove completed downloads from the queue.    <br/>    -Safari 			  		   	  		      		 		   	 			   		   	  			     		 	    	 			   		 	 	  	 			   		   	  		 	 	  		  	 			 Extension Options - Option not to activate Downie when using Safari extension.    <br/>    -Browser Extensions + Postprocessing - Browser extensions are updated and support sending links to Downie with a postprocessing intent.    <br/>    -DASH Stream Support - It\'s a good thing!    <br/>    -HLS Subtitles Support - More weird letters, but trust us, it\'s a good thing.    <br/>    -AAC Support - Option not to enforce MP3 with audio postprocessing.    <br/>    -User-Guided Extraction + Pop-Ups - User-Guided Extraction now supports pop up windows (disabled by default), which allows signing into some services using e.g. Facebook, Google or LinkedIn.    <br/>    <br/>    Improvements    <br/>    -Renaming - Rename downloads during the download or even after they finished.    <br/>    -HLS Streams - Completely rewritten download of HLS streams - it is up to 4 times faster.    <br/>    -Postprocessing - Thanks to Downie\'s new video analysis, the postprocessing for HLS downloads now takes seconds instead of minutes.    <br/>    -History - History window is now extended and includes icon previews.    <br/>    -Quality Selection - Rewritten automatic quality selection so that highest resolution gets always picked.    <br/>    -Support - Ability to send a generic bug report right from the app.    <br/>    -User-Guided Extraction - The User-Guided Extraction has been much improved, highlights more probable downloads, displays details about proposed downloads and can hide the sidebar.    <br/>    -Memory Management - After launch, Downie takes about 10-20MB less memory, the User-Guided Extraction memory cleanup is improved, the Login Browser uses a new generation of web browser on macOS 10.13 or later.    <br/>    -Memory Management 2 - Processing YouTube (and some other) links uses considerably less memory.    <br/>    -â€¦ and many, many other minor fixes and improvements.    <br/>    <br/>    <b>     Compatibility:    </b>    macOS 10.11 or later    <br/>    <br/>    <b>     HomePage    </b>    -    <a href=\"https://software.charliemonroe.net/downie.php\" target=\"_blank\">     https://software.charliemonroe.net/downie.php    </a>   </div>   <div class=\"text download_links\">    <ul>     <li>      <a href=\"/go/3324438/0/\">       Download from icerbox.com      </a>     </li>    </ul>   </div>   <div class=\"player embed-responsive embed-responsive-16by9\" style=\"display:none\">    <video autoplay=\"\" class=\"embed-responsive-item\" controls=\"\" id=\"player\">    </video>   </div>   <div class=\"line\">   </div>  </div> </div></div>',NULL,'2017-10-23 17:55:08','2017-10-23 08:52:49','S',0,'N',NULL),(2,'/magazines/St-Georg--November-2017-38803172.html','A','<div class=\"col-md-12 article\"> <div class=\"row\">  <div class=\"col-lg-12\">   <h1>    <a class=\"title-link\" href=\"/magazines/St-Georg--November-2017-38803172.html\">     St. Georg - November 2017    </a>   </h1>   <div class=\"author visible-lg-inline-block visible-md-inline-block visible-sm-block visible-xs-block\">    <strong>     Posted By:    </strong>    <a href=\"/blogs/Keves\">     Keves    </a>   </div>   <div class=\"post-date visible-lg-inline-block visible-md-inline-block visible-sm-block visible-xs-block\">    <strong>     Date:    </strong>    23 Oct 2017 08:52:29   </div>   <div class=\"text\">    <div class=\"text-center\">     <a href=\"/magazines/St-Georg--November-2017-38803172.html\">      <img alt=\"St. Georg - November 2017\" class=\"img-responsive\" src=\"https://pxhst.co/avaxhome/6d/ad/004aad6d_medium.jpg\"/>     </a>    </div>    <br/>    <div class=\"text-center\">     <b>      St. Georg - November 2017     </b>     <br/>     German | 132 pages | PDF | 110.4 MB    </div>   </div>  </div> </div> <div class=\"row\">  <div style=\"text-align: right\">   <a class=\"details\" href=\"/magazines/St-Georg--November-2017-38803172.html\">    Details   </a>  </div> </div> <div class=\"line\"> </div></div>','<div class=\"col-md-12 article\"> <div class=\"row\">  <div class=\"col-lg-12\">   <h1 class=\"title-link\">    St. Georg - November 2017   </h1>   <div class=\"author visible-lg-inline-block visible-md-inline-block visible-sm-block visible-xs-block\">    <strong>     Posted By:    </strong>    <a href=\"/blogs/Keves\">     Keves    </a>   </div>   <div class=\"post-date visible-lg-inline-block visible-md-inline-block visible-sm-block visible-xs-block\">    <strong>     Date:    </strong>    23 Oct 2017 08:52:29   </div>   <div class=\"row\">    <div class=\"col-lg-1\">     <g:plusone>     </g:plusone>    </div>    <div class=\"col-lg-2\">     <div class=\"fb-like\" data-action=\"like\" data-layout=\"button_count\" data-share=\"false\" data-show-faces=\"true\">     </div>    </div>   </div>   <div class=\"text\">    <div class=\"text-center\">     <a href=\"#\" onclick=\"$(\'#imageModal4894061\').modal(); return false;\">      <img alt=\"St. Georg - November 2017\" class=\"img-responsive\" src=\"https://pxhst.co/avaxhome/6d/ad/004aad6d_medium.jpg\"/>     </a>    </div>    <div aria-labelledby=\"modalLabel4894061\" class=\"modal fade\" id=\"imageModal4894061\" role=\"dialog\" tabindex=\"-1\">     <div class=\"modal-dialog\" role=\"document\" style=\"width: 70%\">      <div class=\"modal-content\">       <div class=\"text-center\">        <div class=\"modal-header\">         <button aria-label=\"Close\" class=\"close\" data-dismiss=\"modal\" type=\"button\">          <span aria-hidden=\"true\">           Ã—          </span>         </button>         <h4 class=\"modal-title\" id=\"modalLabel4894061\">          St. Georg - November 2017         </h4>        </div>        <div class=\"modal-body\">         <a href=\"https://pxhst.co/avaxhome/6d/ad/004aad6d.jpg\" target=\"_blank\">          <img alt=\"St. Georg - November 2017\" class=\"img-responsive\" src=\"https://pxhst.co/avaxhome/6d/ad/004aad6d.jpg\"/>         </a>        </div>        <div class=\"modal-footer\">         <div class=\"text-center\">          <button class=\"btn btn-default\" data-dismiss=\"modal\" type=\"button\">           Close          </button>         </div>        </div>       </div>      </div>     </div>    </div>    <br/>    <div class=\"text-center\">     <b>      St. Georg - November 2017     </b>     <br/>     German | 132 pages | PDF | 110.4 MB    </div>   </div>   <div class=\"text download_links\">    <ul>     <li>      <a href=\"/go/3324437/0/\">       Download from icerbox.com      </a>     </li>    </ul>   </div>   <div class=\"player embed-responsive embed-responsive-16by9\" style=\"display:none\">    <video autoplay=\"\" class=\"embed-responsive-item\" controls=\"\" id=\"player\">    </video>   </div>   <h3>    More issues    <small>     <a href=\"/archive/ed_st-georg/\">      archive     </a>    </small>   </h3>   <div class=\"row text-center\">    <div class=\"col-xs-4 col-md-2\">     <a class=\"thumbnail\" href=\"/magazines/St-Georg--Oktober-2017-25282220.html\">      <img alt=\"St. Georg - Oktober 2017\" height=\"150\" src=\"https://pxhst.co/avaxhome/ff/8a/00498aff_medium.jpg\" width=\"115\"/>      01.09.2017     </a>    </div>   </div>   <div class=\"line\">   </div>  </div> </div></div>',NULL,'2017-10-23 17:55:10','2017-10-23 08:52:49','Z',0,'N',NULL),(3,'/software/givar56004DbrU.html','A','<div class=\"col-md-12 article\"> <div class=\"row\">  <div class=\"col-lg-12\">   <h1>    <a class=\"title-link\" href=\"/software/givar56004DbrU.html\">     VueScan Pro 9.5.90 (x86/x64) Multilingual DC 23.06.2017    </a>   </h1>   <div class=\"author visible-lg-inline-block visible-md-inline-block visible-sm-block visible-xs-block\">    <strong>     Posted By:    </strong>    <a href=\"/blogs/Givaraa\">     Givaraa    </a>   </div>   <div class=\"post-date visible-lg-inline-block visible-md-inline-block visible-sm-block visible-xs-block\">    <strong>     Date:    </strong>    23 Oct 2017 08:46:37   </div>   <div class=\"text\">    <div class=\"text-center\">     <a href=\"/software/givar56004DbrU.html\">      <img alt=\"VueScan Pro 9.5.90 (x86/x64) Multilingual DC 23.06.2017\" class=\"img-responsive\" src=\"https://pxhst.co/avaxhome/62/35/003c3562_medium.jpeg\"/>     </a>    </div>    <br/>    <div class=\"text-center\">     <b>      VueScan Pro 9.5.90 (x86/x64) Multilingual DC 23.06.2017 | 18.9 MB     </b>    </div>    <br/>    VueScan, the world\'s most popular scanner software, is used extensively by photographers, home users, scanning services and corporations. VueScan is a scanning program that works with most high-quality flatbed and film scanners to produce scans that have excellent color fidelity and color balance. It is very easy to use, and also has advanced features for restoring faded colors, batch scanning and other features used by professional photographers.   </div>  </div> </div> <div class=\"row\">  <div style=\"text-align: right\">   <a class=\"details\" href=\"/software/givar56004DbrU.html\">    Details   </a>  </div> </div> <div class=\"line\"> </div></div>','<div class=\"col-md-12 article\"> <div class=\"row\">  <div class=\"col-lg-12\">   <h1 class=\"title-link\">    VueScan Pro 9.5.90 (x86/x64) Multilingual DC 23.06.2017   </h1>   <div class=\"author visible-lg-inline-block visible-md-inline-block visible-sm-block visible-xs-block\">    <strong>     Posted By:    </strong>    <a href=\"/blogs/Givaraa\">     Givaraa    </a>   </div>   <div class=\"post-date visible-lg-inline-block visible-md-inline-block visible-sm-block visible-xs-block\">    <strong>     Date:    </strong>    23 Oct 2017 08:46:37   </div>   <div class=\"row\">    <div class=\"col-lg-1\">     <g:plusone>     </g:plusone>    </div>    <div class=\"col-lg-2\">     <div class=\"fb-like\" data-action=\"like\" data-layout=\"button_count\" data-share=\"false\" data-show-faces=\"true\">     </div>    </div>   </div>   <div class=\"text\">    <div class=\"text-center\">     <a href=\"#\" onclick=\"$(\'#imageModal3945826\').modal(); return false;\">      <img alt=\"VueScan Pro 9.5.90 (x86/x64) Multilingual DC 23.06.2017\" class=\"img-responsive\" src=\"https://pxhst.co/avaxhome/62/35/003c3562_medium.jpeg\"/>     </a>    </div>    <div aria-labelledby=\"modalLabel3945826\" class=\"modal fade\" id=\"imageModal3945826\" role=\"dialog\" tabindex=\"-1\">     <div class=\"modal-dialog\" role=\"document\" style=\"width: 70%\">      <div class=\"modal-content\">       <div class=\"text-center\">        <div class=\"modal-header\">         <button aria-label=\"Close\" class=\"close\" data-dismiss=\"modal\" type=\"button\">          <span aria-hidden=\"true\">           Ã—          </span>         </button>         <h4 class=\"modal-title\" id=\"modalLabel3945826\">          VueScan Pro 9.5.90 (x86/x64) Multilingual DC 23.06.2017         </h4>        </div>        <div class=\"modal-body\">         <a href=\"https://pxhst.co/avaxhome/62/35/003c3562.jpeg\" target=\"_blank\">          <img alt=\"VueScan Pro 9.5.90 (x86/x64) Multilingual DC 23.06.2017\" class=\"img-responsive\" src=\"https://pxhst.co/avaxhome/62/35/003c3562.jpeg\"/>         </a>        </div>        <div class=\"modal-footer\">         <div class=\"text-center\">          <button class=\"btn btn-default\" data-dismiss=\"modal\" type=\"button\">           Close          </button>         </div>        </div>       </div>      </div>     </div>    </div>    <br/>    <div class=\"text-center\">     <b>      VueScan Pro 9.5.90 (x86/x64) Multilingual DC 23.06.2017 | 18.9 MB     </b>    </div>    <br/>    VueScan, the world\'s most popular scanner software, is used extensively by photographers, home users, scanning services and corporations. VueScan is a scanning program that works with most high-quality flatbed and 			  		   	  		      		 		   	 			   		   	  			     		 	    	 			   		 	 	  	 			   		   	  		 	 	  		  	 			 film scanners to produce scans that have excellent color fidelity and color balance. It is very easy to use, and also has advanced features for restoring faded colors, batch scanning and other features used by professional photographers.    <br/>    <br/>    VueScan changes nothing on your system, installs nothing in your operating system and all other scanner software will continue to function. VueScan increases your productivity and saves you money. VueScan has advanced scanning options, powerful features, and greatly improves your scans with superior color accuracy and better color balance. VueScan supports more than 700 scanners and 209 digital camera raw files and takes about 5 minutes to download and install.    <br/>    <br/>    <b>     Features:    </b>    <br/>    â€¢ Works with 1200 flatbed and film scanners    <br/>    â€¢ Runs on Mac OS X, Windows and Linux    <br/>    â€¢ Improves your productivity and quality of scans    <br/>    â€¢ Has been downloaded more than 5 million times    <br/>    â€¢ Create raw scan files    <br/>    â€¢ ICC profiles and color spaces    <br/>    â€¢ IT8 color calibration    <br/>    <br/>    <b>     OS :    </b>    Windows 10/8/7/Vista/XP    <br/>    <b>     Language :    </b>    Multilanguage    <br/>    <br/>    <b>     Home Page -    </b>    <a href=\"http://www.hamrick.com/\" target=\"_blank\">     http://www.hamrick.com/    </a>   </div>   <div class=\"text download_links\">    <ul>     <li>      <a href=\"/go/3324436/0/\">       Download from icerbox.com      </a>     </li>    </ul>   </div>   <div class=\"player embed-responsive embed-responsive-16by9\" style=\"display:none\">    <video autoplay=\"\" class=\"embed-responsive-item\" controls=\"\" id=\"player\">    </video>   </div>   <div class=\"line\">   </div>  </div> </div></div>',NULL,'2017-10-23 17:55:13','2017-10-23 08:52:49','S',0,'N',NULL),(4,'/ebooks/224681121X.html','A','<div class=\"col-md-12 article\"> <div class=\"row\">  <div class=\"col-lg-12\">   <h1>    <a class=\"title-link\" href=\"/ebooks/224681121X.html\">     Adolf Loos, \"Comment doit-on s\'habiller?\"    </a>   </h1>   <div class=\"author visible-lg-inline-block visible-md-inline-block visible-sm-block visible-xs-block\">    <strong>     Posted By:    </strong>    <a href=\"/blogs/TimMa\">     TimMa    </a>   </div>   <div class=\"post-date visible-lg-inline-block visible-md-inline-block visible-sm-block visible-xs-block\">    <strong>     Date:    </strong>    23 Oct 2017 08:46:26   </div>   <div class=\"text\">    <div class=\"text-center\">     <a href=\"/ebooks/224681121X.html\">      <img alt=\"Adolf Loos, &quot;Comment doit-on s\'habiller?&quot;\" class=\"img-responsive\" src=\"https://pxhst.co/avaxhome/6c/ad/004aad6c_medium.jpg\"/>     </a>    </div>    <br/>    <div class=\"text-center\">     <b>      Adolf Loos, \"Comment doit-on s\'habiller?\"     </b>     <br/>     Grasset | 2014 | ISBN: 224681121X | French | EPUB | 120 pages | 0.3 MB    </div>    <br/>    <blockquote>     Adolf Loos (1870-1933) ne fut pas seulement lâ€™architecte rÃ©volutionnaire que lâ€™on sait. Il fut aussi un brillant chroniqueur qui entendait rÃ©veiller lâ€™Autriche du xxe siÃ¨cle en lui inculquant les principes de la modernitÃ©. On trouvera rassemblÃ©s dans ce volume lâ€™ensemble des textes quâ€™il a Ã©crits sur le thÃ¨me du vÃªtement et de la mode. Les chapeaux, les chaussures, les sous-vÃªtements, la terrible apparition de la femme-enfant, rien nâ€™Ã©chappe Ã  cet analyste aussi fin que spirituel. â€¦    </blockquote>   </div>  </div> </div> <div class=\"row\">  <div style=\"text-align: right\">   <a class=\"details\" href=\"/ebooks/224681121X.html\">    Details   </a>  </div> </div> <div class=\"line\"> </div></div>','<div class=\"col-md-12 article\"> <div class=\"row\">  <div class=\"col-lg-12\">   <h1 class=\"title-link\">    Adolf Loos, \"Comment doit-on s\'habiller?\"   </h1>   <div class=\"author visible-lg-inline-block visible-md-inline-block visible-sm-block visible-xs-block\">    <strong>     Posted By:    </strong>    <a href=\"/blogs/TimMa\">     TimMa    </a>   </div>   <div class=\"post-date visible-lg-inline-block visible-md-inline-block visible-sm-block visible-xs-block\">    <strong>     Date:    </strong>    23 Oct 2017 08:46:26   </div>   <div class=\"row\">    <div class=\"col-lg-1\">     <g:plusone>     </g:plusone>    </div>    <div class=\"col-lg-2\">     <div class=\"fb-like\" data-action=\"like\" data-layout=\"button_count\" data-share=\"false\" data-show-faces=\"true\">     </div>    </div>   </div>   <div class=\"text\">    <div class=\"text-center\">     <a href=\"#\" onclick=\"$(\'#imageModal4894060\').modal(); return false;\">      <img alt=\"Adolf Loos, &quot;Comment doit-on s\'habiller?&quot;\" class=\"img-responsive\" src=\"https://pxhst.co/avaxhome/6c/ad/004aad6c_medium.jpg\"/>     </a>    </div>    <div aria-labelledby=\"modalLabel4894060\" class=\"modal fade\" id=\"imageModal4894060\" role=\"dialog\" tabindex=\"-1\">     <div class=\"modal-dialog\" role=\"document\" style=\"width: 70%\">      <div class=\"modal-content\">       <div class=\"text-center\">        <div class=\"modal-header\">         <button aria-label=\"Close\" class=\"close\" data-dismiss=\"modal\" type=\"button\">          <span aria-hidden=\"true\">           Ã—          </span>         </button>         <h4 class=\"modal-title\" id=\"modalLabel4894060\">          Adolf Loos, \"Comment doit-on s\'habiller?\"         </h4>        </div>        <div class=\"modal-body\">         <a href=\"https://pxhst.co/avaxhome/6c/ad/004aad6c.jpg\" target=\"_blank\">          <img alt=\"Adolf Loos, &quot;Comment doit-on s\'habiller?&quot;\" class=\"img-responsive\" src=\"https://pxhst.co/avaxhome/6c/ad/004aad6c.jpg\"/>         </a>        </div>        <div class=\"modal-footer\">         <div class=\"text-center\">          <button class=\"btn btn-default\" data-dismiss=\"modal\" type=\"button\">           Close          </button>         </div>        </div>       </div>      </div>     </div>    </div>    <br/>    <div class=\"text-center\">     <b>      Adolf Loos, \"Comment doit-on s\'habiller?\"     </b>     <br/>     Grasset | 2014 | ISBN: 224681121X | French | EPUB | 120 pages | 0.3 MB    </div>    <br/>    <blockquote>     Adolf Loos (1870-1933) ne fut pas seulement lâ€™architecte rÃ©volutionnaire 			  		   	  		      		 		   	 			   		   	  			     		 	    	 			   		 	 	  	 			   		   	  		 	 	  		  	 			 que lâ€™on sait. Il fut aussi un brillant chroniqueur qui entendait rÃ©veiller lâ€™Autriche du xxe siÃ¨cle en lui inculquant les principes de la modernitÃ©. On trouvera rassemblÃ©s dans ce volume lâ€™ensemble des textes quâ€™il a Ã©crits sur le thÃ¨me du vÃªtement et de la mode. Les chapeaux, les chaussures, les sous-vÃªtements, la terrible apparition de la femme-enfant, rien nâ€™Ã©chappe Ã  cet analyste aussi fin que spirituel. Selon quels critÃ¨res choisir son manteau de fourrure ? Comment avoir lâ€™air dâ€™un gentleman quand on fait du vÃ©lo ? Les femmes doivent-elles porter les cheveux courts ? Une leÃ§on de style.     <br/>     <br/>     InÃ©dit     <br/>     <br/>     Traduit de lâ€™allemand (Autriche) par Anatole Tomczak     <br/>     <br/>     Biographie de l\'auteur     <br/>     Lâ€™architecte viennois Adolf Loos (1870 â€“ 1933) a Ã©tabli les grands principes de lâ€™architecture moderne. Ses rÃ©alisations se caractÃ©risent par un style dâ€™une simplicitÃ© rÃ©volutionnaire, minimaliste avant la lettre. Il a dÃ©clarÃ© la guerre Ã  lâ€™ornement au nom dâ€™une philosophie esthÃ©tique mais aussi sociale, par laquelle il espÃ©rait Â« libÃ©rer lâ€™humanitÃ© du superflu Â».    </blockquote>   </div>   <div class=\"text download_links\">    <ul>     <li>      <a href=\"/go/3324435/0/\">       Download from icerbox.com      </a>     </li>    </ul>   </div>   <div class=\"player embed-responsive embed-responsive-16by9\" style=\"display:none\">    <video autoplay=\"\" class=\"embed-responsive-item\" controls=\"\" id=\"player\">    </video>   </div>   <div class=\"line\">   </div>  </div> </div></div>',NULL,'2017-10-23 17:55:15','2017-10-23 08:52:49','E',0,'N',NULL),(5,'/ebooks/2804187748.html','A','<div class=\"col-md-12 article\"> <div class=\"row\">  <div class=\"col-lg-12\">   <h1>    <a class=\"title-link\" href=\"/ebooks/2804187748.html\">     Chimie PC/PC* 2e annÃ©e tout-en-un : Un accompagnement au quotidien [extrait]    </a>   </h1>   <div class=\"author visible-lg-inline-block visible-md-inline-block visible-sm-block visible-xs-block\">    <strong>     Posted By:    </strong>    <a href=\"/blogs/hill0\">     hill0    </a>   </div>   <div class=\"post-date visible-lg-inline-block visible-md-inline-block visible-sm-block visible-xs-block\">    <strong>     Date:    </strong>    23 Oct 2017 08:45:45   </div>   <div class=\"text\">    <div class=\"text-center\">     <a href=\"/ebooks/2804187748.html\">      <img alt=\"Chimie PC/PC* 2e annÃ©e tout-en-un : Un accompagnement au quotidien [extrait]\" class=\"img-responsive\" src=\"https://pxhst.co/avaxhome/6b/ad/004aad6b_medium.jpg\"/>     </a>    </div>    <br/>    <div class=\"text-center\">     <b>      Chimie PC/PC* 2e annÃ©e tout-en-un : Un accompagnement au quotidien by Tristan Ribeyre     </b>     <br/>     French | 25 July 2014 | ISBN: 2804187748 | 152 pages | PDF | 23.44 MB    </div>   </div>  </div> </div> <div class=\"row\">  <div style=\"text-align: right\">   <a class=\"details\" href=\"/ebooks/2804187748.html\">    Details   </a>  </div> </div> <div class=\"line\"> </div></div>','<div class=\"col-md-12 article\"> <div class=\"row\">  <div class=\"col-lg-12\">   <h1 class=\"title-link\">    Chimie PC/PC* 2e annÃ©e tout-en-un : Un accompagnement au quotidien [extrait]   </h1>   <div class=\"author visible-lg-inline-block visible-md-inline-block visible-sm-block visible-xs-block\">    <strong>     Posted By:    </strong>    <a href=\"/blogs/hill0\">     hill0    </a>   </div>   <div class=\"post-date visible-lg-inline-block visible-md-inline-block visible-sm-block visible-xs-block\">    <strong>     Date:    </strong>    23 Oct 2017 08:45:45   </div>   <div class=\"row\">    <div class=\"col-lg-1\">     <g:plusone>     </g:plusone>    </div>    <div class=\"col-lg-2\">     <div class=\"fb-like\" data-action=\"like\" data-layout=\"button_count\" data-share=\"false\" data-show-faces=\"true\">     </div>    </div>   </div>   <div class=\"text\">    <div class=\"text-center\">     <a href=\"#\" onclick=\"$(\'#imageModal4894059\').modal(); return false;\">      <img alt=\"Chimie PC/PC* 2e annÃ©e tout-en-un : Un accompagnement au quotidien [extrait]\" class=\"img-responsive\" src=\"https://pxhst.co/avaxhome/6b/ad/004aad6b_medium.jpg\"/>     </a>    </div>    <div aria-labelledby=\"modalLabel4894059\" class=\"modal fade\" id=\"imageModal4894059\" role=\"dialog\" tabindex=\"-1\">     <div class=\"modal-dialog\" role=\"document\" style=\"width: 70%\">      <div class=\"modal-content\">       <div class=\"text-center\">        <div class=\"modal-header\">         <button aria-label=\"Close\" class=\"close\" data-dismiss=\"modal\" type=\"button\">          <span aria-hidden=\"true\">           Ã—          </span>         </button>         <h4 class=\"modal-title\" id=\"modalLabel4894059\">          Chimie PC/PC* 2e annÃ©e tout-en-un : Un accompagnement au quotidien [extrait]         </h4>        </div>        <div class=\"modal-body\">         <a href=\"https://pxhst.co/avaxhome/6b/ad/004aad6b.jpg\" target=\"_blank\">          <img alt=\"Chimie PC/PC* 2e annÃ©e tout-en-un : Un accompagnement au quotidien [extrait]\" class=\"img-responsive\" src=\"https://pxhst.co/avaxhome/6b/ad/004aad6b.jpg\"/>         </a>        </div>        <div class=\"modal-footer\">         <div class=\"text-center\">          <button class=\"btn btn-default\" data-dismiss=\"modal\" type=\"button\">           Close          </button>         </div>        </div>       </div>      </div>     </div>    </div>    <br/>    <div class=\"text-center\">     <b>      Chimie PC/PC* 2e annÃ©e tout-en-un : Un accompagnement au quotidien by Tristan Ribeyre     </b>     <br/>     French | 25 July 2014 | ISBN: 2804187748 | 152 pages | PDF | 23.44 MB    </div>   </div>   <div class=\"text download_links\">    <ul>     <li>      <a href=\"/go/3324434/0/\">       Download from icerbox.com      </a>     </li>    </ul>   </div>   <div class=\"player embed-responsive embed-responsive-16by9\" style=\"display:none\">    <video autoplay=\"\" class=\"embed-responsive-item\" controls=\"\" id=\"player\">    </video>   </div>   <div class=\"line\">   </div>  </div> </div></div>',NULL,'2017-10-23 17:55:17','2017-10-23 08:52:49','E',0,'N',NULL),(6,'/software/givar56004DbrEB.html','A','<div class=\"col-md-12 article\"> <div class=\"row\">  <div class=\"col-lg-12\">   <h1>    <a class=\"title-link\" href=\"/software/givar56004DbrEB.html\">     Easy Work Time Calculator 7.0 Build 057 DC 23.10.2017    </a>   </h1>   <div class=\"author visible-lg-inline-block visible-md-inline-block visible-sm-block visible-xs-block\">    <strong>     Posted By:    </strong>    <a href=\"/blogs/Givaraa\">     Givaraa    </a>   </div>   <div class=\"post-date visible-lg-inline-block visible-md-inline-block visible-sm-block visible-xs-block\">    <strong>     Date:    </strong>    23 Oct 2017 08:43:33   </div>   <div class=\"text\">    <div class=\"text-center\">     <a href=\"/software/givar56004DbrEB.html\">      <img alt=\"Easy Work Time Calculator 7.0 Build 057 DC 23.10.2017\" class=\"img-responsive\" src=\"https://pxhst.co/avaxhome/65/4e/00444e65_medium.jpg\"/>     </a>    </div>    <br/>    <div class=\"text-center\">     <b>      Easy Work Time Calculator 7.0 Build 057 DC 23.10.2017 | 1 Mb     </b>    </div>    <br/>    Easy Work Time Calculator is a simple and easy to use worktime calculator. It can calculate/count the time consumption of your jobs by seconds, minutes, hours, days, weeks, months, years and their sum and average. The numbers of date time elements are refreshed automatically on the main interface, and you can set the refreshing frequency. With this program, you can Start, Rename, Delete, Pause, Continue and Stop your jobs, it provides you with a quick filter (according to job status (Started, Paused and Finished), start time (yesterday and today, last week) and an advanced filter (according to job name and custom start time) to see your jobs listing conveniently.   </div>  </div> </div> <div class=\"row\">  <div style=\"text-align: right\">   <a class=\"details\" href=\"/software/givar56004DbrEB.html\">    Details   </a>  </div> </div> <div class=\"line\"> </div></div>','<div class=\"col-md-12 article\"> <div class=\"row\">  <div class=\"col-lg-12\">   <h1 class=\"title-link\">    Easy Work Time Calculator 7.0 Build 057 DC 23.10.2017   </h1>   <div class=\"author visible-lg-inline-block visible-md-inline-block visible-sm-block visible-xs-block\">    <strong>     Posted By:    </strong>    <a href=\"/blogs/Givaraa\">     Givaraa    </a>   </div>   <div class=\"post-date visible-lg-inline-block visible-md-inline-block visible-sm-block visible-xs-block\">    <strong>     Date:    </strong>    23 Oct 2017 08:43:33   </div>   <div class=\"row\">    <div class=\"col-lg-1\">     <g:plusone>     </g:plusone>    </div>    <div class=\"col-lg-2\">     <div class=\"fb-like\" data-action=\"like\" data-layout=\"button_count\" data-share=\"false\" data-show-faces=\"true\">     </div>    </div>   </div>   <div class=\"text\">    <div class=\"text-center\">     <a href=\"#\" onclick=\"$(\'#imageModal4476517\').modal(); return false;\">      <img alt=\"Easy Work Time Calculator 7.0 Build 057 DC 23.10.2017\" class=\"img-responsive\" src=\"https://pxhst.co/avaxhome/65/4e/00444e65_medium.jpg\"/>     </a>    </div>    <div aria-labelledby=\"modalLabel4476517\" class=\"modal fade\" id=\"imageModal4476517\" role=\"dialog\" tabindex=\"-1\">     <div class=\"modal-dialog\" role=\"document\" style=\"width: 70%\">      <div class=\"modal-content\">       <div class=\"text-center\">        <div class=\"modal-header\">         <button aria-label=\"Close\" class=\"close\" data-dismiss=\"modal\" type=\"button\">          <span aria-hidden=\"true\">           Ã—          </span>         </button>         <h4 class=\"modal-title\" id=\"modalLabel4476517\">          Easy Work Time Calculator 7.0 Build 057 DC 23.10.2017         </h4>        </div>        <div class=\"modal-body\">         <a href=\"https://pxhst.co/avaxhome/65/4e/00444e65.jpg\" target=\"_blank\">          <img alt=\"Easy Work Time Calculator 7.0 Build 057 DC 23.10.2017\" class=\"img-responsive\" src=\"https://pxhst.co/avaxhome/65/4e/00444e65.jpg\"/>         </a>        </div>        <div class=\"modal-footer\">         <div class=\"text-center\">          <button class=\"btn btn-default\" data-dismiss=\"modal\" type=\"button\">           Close          </button>         </div>        </div>       </div>      </div>     </div>    </div>    <br/>    <div class=\"text-center\">     <b>      Easy Work Time Calculator 7.0 Build 057 DC 23.10.2017 | 1 Mb     </b>    </div>    <br/>    Easy Work Time Calculator is a simple and easy to use worktime calculator. It can calculate/count the 			  		   	  		      		 		   	 			   		   	  			     		 	    	 			   		 	 	  	 			   		   	  		 	 	  		  	 			 time consumption of your jobs by seconds, minutes, hours, days, weeks, months, years and their sum and average. The numbers of date time elements are refreshed automatically on the main interface, and you can set the refreshing frequency. With this program, you can Start, Rename, Delete, Pause, Continue and Stop your jobs, it provides you with a quick filter (according to job status (Started, Paused and Finished), start time (yesterday and today, last week) and an advanced filter (according to job name and custom start time) to see your jobs listing conveniently.    <br/>    <br/>    Also, copying the value of any field, automatically remembering the order and width of columns / the size and location of window, hiding columns, data backing up/restoring features are provided. Of course, some useful options are built-in: refreshing frequency, precision of the numbers of years, months, weeks, days, hours, minutes and seconds, font name and size of the jobs listing, foreground colors of different job status.    <br/>    <br/>    <b>     OS :    </b>    Windows 10/8/7/Vista/XP    <br/>    <br/>    <b>     Home Page    </b>    -    <a href=\"http://www.trisunsoft.com\" target=\"_blank\">     http://www.trisunsoft.com    </a>   </div>   <div class=\"text download_links\">    <ul>     <li>      <a href=\"/go/3324431/0/\">       Download from icerbox.com      </a>     </li>    </ul>   </div>   <div class=\"player embed-responsive embed-responsive-16by9\" style=\"display:none\">    <video autoplay=\"\" class=\"embed-responsive-item\" controls=\"\" id=\"player\">    </video>   </div>   <div class=\"line\">   </div>  </div> </div></div>',NULL,'2017-10-23 17:55:25','2017-10-23 08:52:49','S',0,'N',NULL),(7,'/ebooks/B00P1NZSQ2.html','A','<div class=\"col-md-12 article\"> <div class=\"row\">  <div class=\"col-lg-12\">   <h1>    <a class=\"title-link\" href=\"/ebooks/B00P1NZSQ2.html\">     Jumpstart Your Leadership: A 90-Day Improvement Plan [Audiobook]    </a>   </h1>   <div class=\"author visible-lg-inline-block visible-md-inline-block visible-sm-block visible-xs-block\">    <strong>     Posted By:    </strong>    <a href=\"/blogs/tarantoga\">     tarantoga    </a>   </div>   <div class=\"post-date visible-lg-inline-block visible-md-inline-block visible-sm-block visible-xs-block\">    <strong>     Date:    </strong>    23 Oct 2017 08:32:21   </div>   <div class=\"text\">    <div class=\"text-center\">     <div class=\"text-center\">      <a href=\"/ebooks/B00P1NZSQ2.html\">       <img alt=\"Jumpstart Your Leadership: A 90-Day Improvement Plan [Audiobook]\" class=\"img-responsive\" src=\"https://pxhst.co/avaxhome/66/ad/004aad66_medium.jpg\"/>      </a>     </div>     <br/>     <b>      John C. Maxwell (Author), Chris Sorensen, \"Jumpstart Your Leadership: A 90-Day Improvement Plan\"     </b>     <br/>     ASIN: B00P1NZSQ2, ISBN: 1478985828 | 2014 | MP3@64 kbps | ~02:13:00 | 63 MB    </div>   </div>  </div> </div> <div class=\"row\">  <div style=\"text-align: right\">   <a class=\"details\" href=\"/ebooks/B00P1NZSQ2.html\">    Details   </a>  </div> </div> <div class=\"line\"> </div></div>','<div class=\"col-md-12 article\"> <div class=\"row\">  <div class=\"col-lg-12\">   <h1 class=\"title-link\">    Jumpstart Your Leadership: A 90-Day Improvement Plan [Audiobook]   </h1>   <div class=\"author visible-lg-inline-block visible-md-inline-block visible-sm-block visible-xs-block\">    <strong>     Posted By:    </strong>    <a href=\"/blogs/tarantoga\">     tarantoga    </a>   </div>   <div class=\"post-date visible-lg-inline-block visible-md-inline-block visible-sm-block visible-xs-block\">    <strong>     Date:    </strong>    23 Oct 2017 08:32:21   </div>   <div class=\"row\">    <div class=\"col-lg-1\">     <g:plusone>     </g:plusone>    </div>    <div class=\"col-lg-2\">     <div class=\"fb-like\" data-action=\"like\" data-layout=\"button_count\" data-share=\"false\" data-show-faces=\"true\">     </div>    </div>   </div>   <div class=\"text\">    <div class=\"text-center\">     <div class=\"text-center\">      <a href=\"#\" onclick=\"$(\'#imageModal4894054\').modal(); return false;\">       <img alt=\"Jumpstart Your Leadership: A 90-Day Improvement Plan [Audiobook]\" class=\"img-responsive\" src=\"https://pxhst.co/avaxhome/66/ad/004aad66_medium.jpg\"/>      </a>     </div>     <div aria-labelledby=\"modalLabel4894054\" class=\"modal fade\" id=\"imageModal4894054\" role=\"dialog\" tabindex=\"-1\">      <div class=\"modal-dialog\" role=\"document\" style=\"width: 70%\">       <div class=\"modal-content\">        <div class=\"text-center\">         <div class=\"modal-header\">          <button aria-label=\"Close\" class=\"close\" data-dismiss=\"modal\" type=\"button\">           <span aria-hidden=\"true\">            Ã—           </span>          </button>          <h4 class=\"modal-title\" id=\"modalLabel4894054\">           Jumpstart Your Leadership: A 90-Day Improvement Plan [Audiobook]          </h4>         </div>         <div class=\"modal-body\">          <a href=\"https://pxhst.co/avaxhome/66/ad/004aad66.jpg\" target=\"_blank\">           <img alt=\"Jumpstart Your Leadership: A 90-Day Improvement Plan [Audiobook]\" class=\"img-responsive\" src=\"https://pxhst.co/avaxhome/66/ad/004aad66.jpg\"/>          </a>         </div>         <div class=\"modal-footer\">          <div class=\"text-center\">           <button class=\"btn btn-default\" data-dismiss=\"modal\" type=\"button\">            Close           </button>          </div>         </div>        </div>       </div>      </div>     </div>     <br/>     <b>      John C. Maxwell (Author), Chris Sorensen, \"Jumpstart Your Leadership: A 90-Day Improvement Plan\"     </b>     <br/>     ASIN: B00P1NZSQ2, ISBN: 1478985828 | 2014 | MP3@64 kbps | ~02:13:00 | 63 MB    </div>    <br/>    John C. Maxwell, number one New York Times best-selling author, presents his 			  		   	  		      		 		   	 			   		   	  			     		 	    	 			   		 	 	  	 			   		   	  		 	 	  		  	 			 90-day guide to improving your leadership. Whether you want to increase your influence, prepare yourself for that big promotion, or get a handle on leadership for the first time, you can trust John Maxwell to help you in the journey. JumpStart Your Leadership will give you the insight, inspiration, and instruction you need to see tangible improvement in your leadership skills in 90 days.    <br/>    <br/>    Maxwell gives you clear leadership principles, prompts you to examine yourself, and provides actionable step to help you become the leader you\'ve always wanted to be. And there is space for you to take notes and document your journey.    <br/>    <br/>    Maxwell says, \"Leadership develops daily, not in a day.\" This portable volume will give you the tools to develop as a leader and activate your leadership potential.    <br/>    <br/>    Derived from content originally published in The 5 Levels of Leadership.    <br/>    <br/>    <div class=\"text-center\">     <b>      <a href=\"https://avxhm.se/blogs/tarantoga\" onclick=\"log_click(\'Jumpstart%20Your%20Leadership%3A%20A%2090-Day%20Improvement%20Plan%20%5BAudiobook%5D\', \'avxhm.se\'); return true;\" rel=\"nofollow noopener noreferrer\" target=\"_blank\">       Visit my blog for more eBooks and Audiobooks      </a>     </b>     |     <a href=\"http://avxhome.se/blogs/tarantoga/rss.xml\" onclick=\"log_click(\'Jumpstart%20Your%20Leadership%3A%20A%2090-Day%20Improvement%20Plan%20%5BAudiobook%5D\', \'avxhome.se\'); return true;\" rel=\"nofollow noopener noreferrer\" target=\"_blank\">      <b>       RSS      </b>     </a>    </div>   </div>   <div class=\"text download_links\">    <ul>     <li>      <a href=\"/go/3324428/0/\">       Download from icerbox.com      </a>     </li>    </ul>   </div>   <div class=\"player embed-responsive embed-responsive-16by9\" style=\"display:none\">    <video autoplay=\"\" class=\"embed-responsive-item\" controls=\"\" id=\"player\">    </video>   </div>   <div class=\"line\">   </div>  </div> </div></div>',NULL,'2017-10-23 17:55:28','2017-10-23 08:52:49','E',0,'N',NULL);
/*!40000 ALTER TABLE `ContentSnippets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `InterestingSnippets`
--

DROP TABLE IF EXISTS `InterestingSnippets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `InterestingSnippets` (
  `CS_ID` int(11) NOT NULL,
  `IT_ID` int(11) NOT NULL,
  PRIMARY KEY (`CS_ID`,`IT_ID`),
  KEY `FK_R_IT_IS` (`IT_ID`),
  KEY `InterestingSnippets_PK` (`CS_ID`,`IT_ID`),
  CONSTRAINT `FK_R_CS_IS` FOREIGN KEY (`CS_ID`) REFERENCES `ContentSnippets` (`CS_ID`),
  CONSTRAINT `FK_R_IT_IS` FOREIGN KEY (`IT_ID`) REFERENCES `InterestingTerms` (`IT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `InterestingSnippets`
--

LOCK TABLES `InterestingSnippets` WRITE;
/*!40000 ALTER TABLE `InterestingSnippets` DISABLE KEYS */;
/*!40000 ALTER TABLE `InterestingSnippets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `InterestingTerms`
--

DROP TABLE IF EXISTS `InterestingTerms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `InterestingTerms` (
  `IT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK of Interesting Terms',
  `InterestingTerm` varchar(64) NOT NULL,
  `CategoryID` char(1) NOT NULL COMMENT 'Reference to Category Record',
  `IsActive` char(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`IT_ID`),
  UNIQUE KEY `InterestingTerms_PK` (`IT_ID`),
  KEY `FK_R_Cat_IT` (`CategoryID`),
  KEY `InterestingTerm_Idx` (`IsActive`,`CategoryID`,`InterestingTerm`),
  CONSTRAINT `FK_R_Cat_IT` FOREIGN KEY (`CategoryID`) REFERENCES `Categories` (`CategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `InterestingTerms`
--

LOCK TABLES `InterestingTerms` WRITE;
/*!40000 ALTER TABLE `InterestingTerms` DISABLE KEYS */;
/*!40000 ALTER TABLE `InterestingTerms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LPlatformTypes`
--

DROP TABLE IF EXISTS `LPlatformTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LPlatformTypes` (
  `PlatformTypeID` char(1) NOT NULL COMMENT 'PK of a Platform type (Lookup) record with A,W,L,P,M,N as values',
  `PlatformTypeName` varchar(10) NOT NULL COMMENT 'Platform type name',
  `IsIgnored` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`PlatformTypeID`),
  UNIQUE KEY `LPLATFORMTYPES_PK` (`PlatformTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LPlatformTypes`
--

LOCK TABLES `LPlatformTypes` WRITE;
/*!40000 ALTER TABLE `LPlatformTypes` DISABLE KEYS */;
INSERT INTO `LPlatformTypes` VALUES ('N','None','N'),('P','PDAs','N'),('W','MS Win','N');
/*!40000 ALTER TABLE `LPlatformTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Languages`
--

DROP TABLE IF EXISTS `Languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Languages` (
  `LanguageID` smallint(6) NOT NULL COMMENT 'PK of a Language (Lookup) record',
  `LanguageName` varchar(64) NOT NULL COMMENT 'Language Name\n            ',
  `IsIgnored` char(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`LanguageID`),
  UNIQUE KEY `LLanguages_PK` (`LanguageID`),
  UNIQUE KEY `LanguageName_Idx` (`LanguageName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Languages`
--

LOCK TABLES `Languages` WRITE;
/*!40000 ALTER TABLE `Languages` DISABLE KEYS */;
INSERT INTO `Languages` VALUES (0,'Unknown','Y'),(1,'English','N'),(2,'French','Y'),(3,'German','N'),(4,'Spanish','Y'),(5,'Italian','Y'),(6,'Russian','Y'),(7,'Portuguese','Y'),(8,'Chinese','Y'),(10,'Armenian','Y'),(11,'Arabic','Y'),(12,'Czech','Y'),(13,'Georgian','Y'),(14,'Greek','Y'),(15,'Hebrew','Y'),(16,'Hindi','Y'),(17,'Hungarian','Y'),(18,'Japanese','Y'),(19,'Korean','Y'),(20,'Norwegian','Y'),(21,'Polish','Y'),(22,'Turkish','Y');
/*!40000 ALTER TABLE `Languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LastRecordsSeen`
--

DROP TABLE IF EXISTS `LastRecordsSeen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LastRecordsSeen` (
  `CS_ID` int(11) NOT NULL,
  `CategoryID` char(1) NOT NULL,
  `LastPublDate` datetime NOT NULL,
  `DisplayTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`CS_ID`),
  KEY `FK_Reference_17` (`CategoryID`),
  KEY `LastRecordsSeen_PK` (`CS_ID`),
  CONSTRAINT `FK_Reference_17` FOREIGN KEY (`CategoryID`) REFERENCES `Categories` (`CategoryID`),
  CONSTRAINT `FK_Reference_18` FOREIGN KEY (`CS_ID`) REFERENCES `ContentSnippets` (`CS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LastRecordsSeen`
--

LOCK TABLES `LastRecordsSeen` WRITE;
/*!40000 ALTER TABLE `LastRecordsSeen` DISABLE KEYS */;
/*!40000 ALTER TABLE `LastRecordsSeen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NLZSnippets`
--

DROP TABLE IF EXISTS `NLZSnippets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NLZSnippets` (
  `CS_ID` int(11) NOT NULL,
  `NLZ_ID` int(11) NOT NULL,
  PRIMARY KEY (`CS_ID`,`NLZ_ID`),
  KEY `FK_R_NLZ_NZS` (`NLZ_ID`),
  KEY `NLZSnippets_PK` (`CS_ID`,`NLZ_ID`),
  CONSTRAINT `FK_R_CS_NZS` FOREIGN KEY (`CS_ID`) REFERENCES `ContentSnippets` (`CS_ID`),
  CONSTRAINT `FK_R_NLZ_NZS` FOREIGN KEY (`NLZ_ID`) REFERENCES `NewsLettersZines` (`NLZ_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NLZSnippets`
--

LOCK TABLES `NLZSnippets` WRITE;
/*!40000 ALTER TABLE `NLZSnippets` DISABLE KEYS */;
/*!40000 ALTER TABLE `NLZSnippets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NewsLettersZines`
--

DROP TABLE IF EXISTS `NewsLettersZines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NewsLettersZines` (
  `NLZ_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK of NewsLettersZines',
  `NLZNames` varchar(64) NOT NULL,
  `CategoryID` char(1) NOT NULL COMMENT 'Reference to Category Record',
  `IsIgnored` char(1) NOT NULL DEFAULT 'C',
  PRIMARY KEY (`NLZ_ID`),
  UNIQUE KEY `NewsLettersZines_PK` (`NLZ_ID`),
  KEY `FK_R_Cat_NLZ` (`CategoryID`),
  CONSTRAINT `FK_R_Cat_NLZ` FOREIGN KEY (`CategoryID`) REFERENCES `Categories` (`CategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NewsLettersZines`
--

LOCK TABLES `NewsLettersZines` WRITE;
/*!40000 ALTER TABLE `NewsLettersZines` DISABLE KEYS */;
/*!40000 ALTER TABLE `NewsLettersZines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OutputListPages`
--

DROP TABLE IF EXISTS `OutputListPages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OutputListPages` (
  `QP_ID` int(11) NOT NULL COMMENT 'PK of interestingDetails (part1/2) - reference to QueryPages',
  `CS_ID` int(11) NOT NULL COMMENT 'PK of InterestingDetails (part2/2) - reference to ContentSnippets',
  `SeqNum` varchar(64) NOT NULL,
  `InterestedInDetail` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`QP_ID`,`CS_ID`),
  KEY `FK_R_CS_OLP` (`CS_ID`),
  KEY `InterestingDetails_PK` (`QP_ID`,`CS_ID`,`SeqNum`),
  KEY `InterestedInDetail_Idx` (`QP_ID`,`InterestedInDetail`,`SeqNum`),
  CONSTRAINT `FK_R_CS_OLP` FOREIGN KEY (`CS_ID`) REFERENCES `ContentSnippets` (`CS_ID`),
  CONSTRAINT `FK_R_QP_OLP` FOREIGN KEY (`QP_ID`) REFERENCES `QueryPages` (`QP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OutputListPages`
--

LOCK TABLES `OutputListPages` WRITE;
/*!40000 ALTER TABLE `OutputListPages` DISABLE KEYS */;
INSERT INTO `OutputListPages` VALUES (1,1,'1','N'),(1,2,'2','N'),(1,3,'3','N'),(1,4,'4','N'),(1,5,'5','N'),(1,6,'6','N'),(1,7,'7','N');
/*!40000 ALTER TABLE `OutputListPages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QueryPages`
--

DROP TABLE IF EXISTS `QueryPages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QueryPages` (
  `QP_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK of QueryPages',
  `WebSiteID` char(1) NOT NULL DEFAULT 'A' COMMENT 'Reference to Website Record',
  `PageURL` varchar(64) NOT NULL,
  `PublDate` varchar(64) DEFAULT NULL COMMENT 'Publication date of content (YYYY/MM/DD)',
  `ScanDate` datetime NOT NULL,
  PRIMARY KEY (`QP_ID`),
  UNIQUE KEY `QueryPages_PK` (`QP_ID`),
  KEY `FK_R_WS_QP` (`WebSiteID`),
  CONSTRAINT `FK_R_WS_QP` FOREIGN KEY (`WebSiteID`) REFERENCES `Websites` (`WebSiteID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QueryPages`
--

LOCK TABLES `QueryPages` WRITE;
/*!40000 ALTER TABLE `QueryPages` DISABLE KEYS */;
INSERT INTO `QueryPages` VALUES (1,'A','https://avxhm.se',NULL,'2017-10-23 17:55:03');
/*!40000 ALTER TABLE `QueryPages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TaskList`
--

DROP TABLE IF EXISTS `TaskList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TaskList` (
  `TaskID` int(11) NOT NULL AUTO_INCREMENT,
  `WebSiteID` char(1) NOT NULL DEFAULT 'A',
  `SearchTerms` varchar(64) NOT NULL,
  `DateCategory` varchar(64) NOT NULL,
  `IsDone` char(1) NOT NULL DEFAULT 'N',
  `QP_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`TaskID`),
  KEY `FK_R_QP_TL` (`QP_ID`),
  KEY `FK_R_WS_TL` (`WebSiteID`),
  KEY `TaskList_PK` (`TaskID`),
  CONSTRAINT `FK_R_QP_TL` FOREIGN KEY (`QP_ID`) REFERENCES `QueryPages` (`QP_ID`),
  CONSTRAINT `FK_R_WS_TL` FOREIGN KEY (`WebSiteID`) REFERENCES `Websites` (`WebSiteID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TaskList`
--

LOCK TABLES `TaskList` WRITE;
/*!40000 ALTER TABLE `TaskList` DISABLE KEYS */;
/*!40000 ALTER TABLE `TaskList` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Websites`
--

DROP TABLE IF EXISTS `Websites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Websites` (
  `WebSiteID` char(1) NOT NULL COMMENT 'PK of supported Websites',
  `WebSiteURL` varchar(64) NOT NULL,
  PRIMARY KEY (`WebSiteID`),
  UNIQUE KEY `Websites_PK` (`WebSiteID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Websites`
--

LOCK TABLES `Websites` WRITE;
/*!40000 ALTER TABLE `Websites` DISABLE KEYS */;
INSERT INTO `Websites` VALUES ('A','https://avxhm.se/'),('G','https://google.com/');
/*!40000 ALTER TABLE `Websites` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-10-23 18:01:31
