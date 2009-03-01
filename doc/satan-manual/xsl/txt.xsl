<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="http://docbook.sourceforge.net/release/xsl/current/xhtml/docbook.xsl" />

	<xsl:param name="section.autolabel">1</xsl:param>
	<xsl:param name="section.label.includes.component.label">1</xsl:param>

	<xsl:param name="generate.toc">
		appendix		title
		article/appendix	nop
		article			toc,title
		book			toc,title,figure,table,example,equation
		chapter			title
		part			toc,title
		preface			toc,title
		qandadiv		toc
		qandaset		toc
		reference		toc,title
		sect1			toc
		sect2			toc
		sect3			toc
		sect4			toc
		sect5			toc
		section			toc
		set			toc,title
	</xsl:param>
</xsl:stylesheet>
