<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:px="http://www.daisy.org/ns/pipeline/xproc"
                xmlns:pf="http://www.daisy.org/ns/pipeline/functions"
                xmlns:cx="http://xmlcalabash.com/ns/extensions"
                type="px:dtbook-to-latex.script"
                px:input-filesets="dtbook"
                px:output-filesets="latex">

	<p:documentation xmlns="http://www.w3.org/1999/xhtml">
		<h1 px:role="name">DTBook to LaTeX (SBS)</h1>
		<p px:role="desc">Transforms a DTBook (DAISY 3 XML) document into a LaTeX document.</p>
	</p:documentation>

	<!--
		These inputs and options are automatically copied from
		http://www.daisy.org/pipeline/modules/dtbook-to-latex/dtbook-to-latex.script.xpl
	-->
	<p:input port="source"/>
	<p:option name="font-size"/>
	<p:option name="result"/>

	<cx:import href="http://www.daisy.org/pipeline/modules/file-utils/library.xsl" type="application/xslt+xml">
		<p:documentation>
			pf:normalize-uri
		</p:documentation>
	</cx:import>

	<p:variable name="base-name" select="replace(replace(base-uri(/),'^.*/([^/]+)$','$1'),'\.[^\.]*$','')">
		<p:documentation>File name without extension</p:documentation>
	</p:variable>

	<p:xslt>
		<p:input port="stylesheet">
			<p:document href="dtbook-to-latex-sbs.xsl"/>
		</p:input>
		<p:with-param name="fontsize" select="$font-size"/>
	</p:xslt>

	<p:store method="text">
		<p:with-option name="href" select="pf:normalize-uri(concat($result,'/',$base-name,'.tex'))"/>
	</p:store>

</p:declare-step>
