<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ui="ui" xmlns:e="entity" xmlns:xhtml="xhtml" xmlns:page="page" xmlns="html" xmlns:exslt="http://exslt.org/common" exclude-result-prefixes="exslt page e ui html xhtml">

	<!-- <Includes> -->
	
    <!--xsl:import href="template_grids.xsl"/-->
    
    <xsl:output method="html" omit-xml-declaration="yes" indent="no"/>
    
    <xsl:strip-space elements="*" />
        
    <!-- <Data> -->
    
    <page:page name="about" title="Dashboard : Ситуационный центр"></page:page>
    
    <xsl:param name="menuXml">

		<page:subnav>
			<!--
			<page:item href="/монитор" code="монитор" title="МОНИТОРИНГ"/>
			<page:item href="/финансы" code="финансы" title="ФИНАНСОВЫЕ"/>
			<page:item href="/почта" code="почта" title="ПОЧТОВЫЕ"/>
			<page:item href="/статистика" code="статистика" title="ОБЩАЯ СТАТИСТИКА"/>
			<page:item href="/закупки" code="закупки" title="ЗАКУП"/>
			-->
			<page:item href="../index.html?tab=tabMonitor" code="монитор" title="МОНИТОРИНГ"/>
			<page:item href="../index.html?tab=tabFin" code="финансы" title="ФИНАНСОВЫЕ"/>
			<page:item href="../index.html?tab=tabPost" code="почта" title="ПОЧТОВЫЕ"/>
			<page:item href="../index.html?tab=tabAgent" code="агенты" title="АГЕНТСКИЕ"/>
			<page:item href="../index.html?tab=tabCommerce" code="коммерс" title="ОНЛАЙН"/>
			<page:item href="../index.html?tab=tabTotal" code="статистика" title="ОБЩАЯ СТАТИСТИКА"/>
			<page:item href="../index.html?tab=tabZakup" code="закупки" title="ЗАКУПКИ"/>
			<page:item href="../index.html?tab=tabIsp" code="исп" title="ИСП"/>
		</page:subnav>
		<page:subnav>
			<page:item href="/trafficmap" code="СВЕТОФОР" title="СВЕТОФОР"/>
			<page:item href="/очереди/index.xhtml" code="очереди" title="ОЧЕРЕДИ"/>
			<page:item href="/карта" code="карта" title="ФИЛПАСПОРТ"/>
		</page:subnav>
		<page:subnav>
			<page:item href="/трекинг" code="трекинг" title="ТРЕКИНГ"/>
		</page:subnav>
    </xsl:param>
    
    <xsl:variable name="title" select="(/ui:page/title | exslt:node-set($pageXml)/page:title)[1]"/>
    <xsl:variable name="page" select="(/ui:page/page:page | exslt:node-set($pageXml)/page:page)[1]"/>
    <xsl:variable name="subnav" select="exslt:node-set($menuXml)/page:subnav"/>
    
    <xsl:variable name="page_name" select="/ui:page/@name"/>
    
        
	<!-- <Root> -->

	<xsl:template match="/ui:page">
		<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
		<html style="background-color:#3e4045;">
		<head>
		    <meta charset="utf-8"/>
		    <title><xsl:value-of select="$title"/> - АО Казпочта</title>
		    <meta name="viewport" content="width=1920,height=1200"/>
		    
		    <link type="image/x-icon" rel="shortcut icon" href="/favicon.png" /> 
    		<link type="image/x-icon" rel="icon" href="/favicon.png" /> 
		    
		    <link rel="stylesheet" type="text/css" href="/_css/style.css" />
		    <link rel="stylesheet" type="text/css" href="/_css/roboto.css" />
		    
		    <xsl:for-each select="$page/xhtml:link">
            	<link rel="stylesheet" type="text/css" media="all" href="{@href}" />
            </xsl:for-each>
            
            <xsl:apply-templates select="link"/>
            <xsl:apply-templates select="style"/>
            
            <script type="text/javascript" src="/_js/jquery-1.11.1.js"></script>
            
            <xsl:for-each select="$page/xhtml:script">
            	<script type="{@type}" src="{@src}"></script>
            </xsl:for-each>
		    
            <xsl:apply-templates select="script"/>
		    
        </head>
        <body style="background-color:#3e4045;">
	        
            <div id="errormsg"></div>
            <xsl:call-template name="body"/>
	        <xsl:call-template name="footer"/>
	        
	        <script type="text/javascript" >
        	    var check = getCookie('hash_text');
			    var hash_int = getCookie('hash_int');
			    if(check != ''){
			        $.ajax({
			            url: "/api/kp_sys_utils/CheckLogin.html",
			            type: "GET",
			            data: {
			                "username": check,
			                "key": hash_int,
			            },
			            success: function(xml) {                
			                var xmltxt = $.parseXML(xml);
			                if ($(xmltxt).find('result').text() == '0'){
			                    console.log('success');
			                }
			                else{
			                    $(location).attr('href','http://test.monitor.kazpost.kz/login/autorization.html');
			                }
			            }
			        });
			    } else
			        $(location).attr('href','http://test.monitor.kazpost.kz/login/autorization.html');
	        	// Имитируем бейджики, посещения 
		    	var val = [0,0,0,0,0,0,0,0,0];
		    	/*setInterval(function() {
					$(".badge").each(function(i,e){
						
						Math.random()*10 &gt;= 8 ? val[i]++ : val[i]--;
		    			if(val[i] &lt; 0) val[i] = 0;
						$(this).css("opacity",(val[i] &gt; 0) ? 1 : 0);
			    		$(this).text(val[i]);
					});
				}, 5000);*/
		    	
		   		//$("#username").text(document.cookie.match("USERNAME"+"=([^;]+)")[1]);
		    	
		    </script>
        </body>
    </html>
    </xsl:template>
    

<xsl:template name="body">
	<div class="body">
	    <xsl:call-template name="header"/>
	    <xsl:call-template name="content"/>
	</div>
</xsl:template>

<xsl:template name="content">
	<div id="wrap" class="content">
        <xsl:apply-templates select="ui:body"/>
    </div>
</xsl:template>

<xsl:template name="header">
	<div class="head">
		<xsl:call-template name="menu"/>
		<!-- Login menu -->
		<xsl:call-template name="login-menu"/>
	</div>
</xsl:template>


<xsl:template name="login-menu">
	<div class="menu-utils" style="float:right;margin-top: -10px;text-align: center;">
	    <!--div class="user">Пользователь, <b id="username"--><!--#echo var="USERNAME"--><!--/b></div-->
	    <table>
    		<tr>
    			<td>Пользователь :</td>
    			<td>
    				<b id="username"></b>
    				<a onclick='logOut();' style='float:right; font-size:12px;'>Выход</a>
    			</td>
    		</tr>
    		<tr>
    			<td>Режим :</td>
    			<td>
        <div class="settings-panel"><a href="/presentation">Презентация</a> <!--  &bull; <a href="#">Выход</a--></div>
    			</td>
    		</tr>
    	</table>
	</div>
	<script type="text/javascript" >
		
    </script>
</xsl:template>


<xsl:template name="menu">
	<menu style="float: left; padding-left:0px;">
		<xsl:apply-templates select="$subnav"/>
	</menu>
</xsl:template>

<xsl:template match="page:subnav">
	<group>
		<!--xsl:apply-templates select="descendant-or-self::page:item[@code=$page_name]/ancestor-or-self::page:item"/-->
		<xsl:apply-templates select="page:item"/>
	</group>
</xsl:template>

<xsl:template match="page:item">
	<xsl:element name="a">
    	<xsl:if test="@code=$page_name"><xsl:attribute name="class">selected</xsl:attribute></xsl:if>
        <xsl:attribute name="href">
            <xsl:choose>
                <xsl:when test="@href"><xsl:value-of select="@href"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="concat($page/@name,'_',@code,'.xml')"/></xsl:otherwise>
            </xsl:choose>
    	</xsl:attribute>
        <xsl:value-of select="@title"/>
    </xsl:element>
    <span class="badge" style="opacity:0">0</span>
</xsl:template>
        
<xsl:template name="footer">      
    <footer>&#169;  2015 Copyright. ИАС Ситуационный центр. Департамент Информационных Технологий. АО Казпочта. Email:<a href="mailto:it@kazpost.kz">it@kazpost.kz</a> 
    	<span>Менеджеры проекта: <a href="mailto:aliya.kairbekova@kazpost.kz">Каирбекова Алия</a> (Tel:1318)</span>		
    </footer>
</xsl:template>

<xsl:template match="ui:body">
   <xsl:apply-templates/>
</xsl:template>

<!--xsl:template match="node() | @*">
    <xsl:copy>
        <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
</xsl:template-->

<!-- template to copy elements -->
<xsl:template match="*">
    <xsl:element name="{local-name()}">
        <xsl:apply-templates select="@* | node()"/>
    </xsl:element>
</xsl:template>

<xsl:template match="br">
<xsl:if test="not(preceding-sibling::node()
                        [not(self::text() and normalize-space(.) = '')][1]
                        [self::br])">
      <xsl:copy>
          <xsl:apply-templates select="@*|node()" />
      </xsl:copy>
   </xsl:if>
</xsl:template>

<!-- template to copy attributes -->
<xsl:template match="@*">
    <xsl:attribute name="{local-name()}">
        <xsl:value-of select="." disable-output-escaping="yes"/>
    </xsl:attribute>
</xsl:template>

<xsl:template match="@*" mode="html">
    <xsl:attribute name="{local-name()}">
        <xsl:value-of select="." disable-output-escaping="yes"/>
    </xsl:attribute>
</xsl:template>

<!-- template to copy the rest of the nodes -->
<xsl:template match="comment() | text()">
    <xsl:value-of select="." disable-output-escaping="yes"/>
</xsl:template>


<xsl:template match="style">
   <xsl:element name="style">
      	<xsl:value-of select="." disable-output-escaping="yes"/>
   </xsl:element>
</xsl:template>

</xsl:stylesheet>