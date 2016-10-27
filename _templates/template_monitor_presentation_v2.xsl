<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ui="ui" xmlns:e="entity" xmlns:xhtml="xhtml" xmlns:page="page" xmlns="html" xmlns:exslt="http://exslt.org/common" exclude-result-prefixes="exslt page e ui html xhtml">

	<!-- <Includes> -->
	
    <xsl:import href="template_monitor.xsl"/>
    
    <xsl:param name="pageXml">
    	<page:page>
			<xhtml:link rel="stylesheet" type="text/css" href="_css/highcharts.css"/>
			<xhtml:link rel="stylesheet" type="text/css" href="_css/presentation.css"/>
			<xhtml:link rel="stylesheet" type="text/css" href="_assets/nprogress/nprogress.css"/>
		    <xhtml:script type="text/javascript" src="_assets/highcharts/highcharts.js"></xhtml:script>
		    <xhtml:script type="text/javascript" src="_assets/nprogress/nprogress.js"></xhtml:script>
		    <xhtml:script type="text/javascript" src="_js/highcharts_config.js"></xhtml:script>
		    <xhtml:script type="text/javascript" src="_js/reports_presentation.js"></xhtml:script>
		</page:page>
    </xsl:param>
        
	<!-- <Root> -->
	
	<xsl:variable name="reportsXml">
		<xsl:for-each select="ui:page/ui:presentation">
			<xsl:apply-templates select="document(@url)/ui:page/ui:body/descendant::ui:report[@presentation]" mode="copy"/>
		</xsl:for-each>
	</xsl:variable>
	
	<xsl:variable name="reports" select="exslt:node-set($reportsXml)/ui:report"/>
	
	<xsl:template match="*" mode="copy">
	  <xsl:copy>
	    <xsl:copy-of select="@*" />
	    <xsl:apply-templates mode="copy" />
	  </xsl:copy>
	</xsl:template>
	
	<xsl:template name="body">
		<xsl:apply-templates select="ui:subhead"/>
		<!--xsl:apply-templates select="ui:body"/-->
		<!--xsl:apply-templates select="ui:presentation"/-->
		<xsl:apply-templates select="$reports"/>
	</xsl:template>
	
	<!--xsl:template match="ui:presentation">
	    <xsl:apply-templates select="document(@url)/ui:page/ui:body/ui:report" />
	</xsl:template-->
	
	<xsl:template name="footer">      
		<div class="footer">
			<div class="poweredby"></div>
		</div>
	</xsl:template>
	
    <xsl:template match="ui:subhead">
    <div class="header">
	    <div class="reports-menu">
	    	<div class='zero-menu'>
				<button style='float:right;margin-top:-20px;margin-right:-5px;' onclick='getOut()'>Выход</button>
	    	</div>
	    	<div class='first-menu' style='margin-top:20px;'>
	    		<xsl:apply-templates select="$reports" mode="menu"/>
	    	</div>
	    	<div class='second-menu'>
	    		<a>15</a><a>30</a><a class="selected">60</a><a id='play_pause'>||</a>
	    	</div>
	    </div>
	    <div style="clear:both"></div>
	</div>
    </xsl:template>
    
    <xsl:template match="ui:report" mode="menu">
	    <a id="button_{@id}" href="#" title="{@title}"><xsl:value-of select="position()"/></a>
    </xsl:template>
    
    
    <xsl:template match="ui:report">
    	<xsl:call-template name="report-script"/>
	    <div class="appearing" id="report_{@id}" report="{@id}">
		<xsl:attribute name="style">height:100%; min-height:400px;
			<!--xsl:if test="@width">width:<xsl:value-of select="@width"/>; float:left;</xsl:if-->
			<xsl:if test="position()!=1">display:none;</xsl:if>
		</xsl:attribute>
		<div class="subhead" style="display:inline-block; float:left;">
	        
			<xsl:if test="@title">
				<h2 style='font-size:22px;'>
					<span class="icon graph"></span><xsl:value-of select="@title"/>&#160;
				</h2>
			</xsl:if>
	         <xsl:if test="@sub">
	         	<div class="subh3" style=''>
	         		<xsl:value-of select="@sub"/>&#160;<span class='period'></span>
	         		<span name="{@id}" class="date">на</span>
	         	</div>
	         </xsl:if>
	        <div style='margin-left:25px;'>
				<xsl:apply-templates select="text()|img|h3|h2|h1|span|div|pre|sup|sub|b|i|br"/>
	        </div> 
	    </div>
			<div id="tbl_{@id}"></div>
			<xsl:apply-templates select="ui:graph"/>
			<div id="tbl_{@id}_dtl" style="display:none;"></div>
			
		</div>
    </xsl:template>

</xsl:stylesheet>