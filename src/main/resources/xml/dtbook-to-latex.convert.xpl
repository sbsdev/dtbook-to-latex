<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:px="http://www.daisy.org/ns/pipeline/xproc"
    xmlns:pxi="http://www.daisy.org/ns/pipeline/xproc/internal"
    xmlns:d="http://www.daisy.org/ns/pipeline/data"
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:sbs="http://www.sbs.ch/pipeline"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-inline-prefixes="px pxi d sbs"
    type="sbs:dtbook-to-latex.convert" name="convert" version="1.0">
    
    <p:input port="fileset.in"/>
    <p:input port="in-memory.in" sequence="true"/>
    <p:option name="output-dir" required="true"/>
    <p:option name="fontsize" required="true"/>
    <p:option name="font" required="true"/>
    <p:option name="backup-font" required="true"/>
    <p:option name="backup-unicode-ranges" required="true"/>
    <p:option name="default-language" required="true"/>
    <p:option name="stocksize" required="true"/>
    <p:option name="alignment" required="true"/>
    <p:option name="page-style" required="true"/>
    <p:option name="line-spacing" required="true"/>
    <p:option name="paperwidth" required="true"/>
    <p:option name="paperheight" required="true"/>
    <p:option name="left-margin" required="true"/>
    <p:option name="right-margin" required="true"/>
    <p:option name="top-margin" required="true"/>
    <p:option name="bottom-margin" required="true"/>
    <p:option name="replace-em-with-quote" required="true"/>
    <p:option name="endnotes" required="true"/>

    <p:output port="fileset.out">
        <p:pipe step="fileset" port="result"/>
    </p:output>
    <p:output port="in-memory.out" sequence="true">
        <p:pipe step="latex" port="result"/>
    </p:output>
    
    <p:import href="utils/normalize-uri.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl"/>
    
    <pxi:normalize-uri>
        <p:with-option name="href" select="concat($output-dir,'/')"/>
    </pxi:normalize-uri>
    
    <px:fileset-create>
        <p:with-option name="base" select="string(c:result)"/>
    </px:fileset-create>
    
    <px:fileset-add-entry media-type="application/x-latex" name="fileset">
        <p:with-option name="href" select="replace(base-uri(/*),'^.*/([^/]*)\.[^/\.]*$','$1.tex')">
            <p:pipe step="convert" port="in-memory.in"/>
        </p:with-option>
    </px:fileset-add-entry>
    <p:sink/>
    
    <p:xslt>
        <p:input port="source">
            <p:pipe step="convert" port="in-memory.in"/>
        </p:input>
        <p:input port="stylesheet">
            <p:inline>
                <xsl:stylesheet version="2.0">
                    <xsl:import href="dtbook2latex_sbs.xsl"/>
                    <xsl:template match="/">
                        <xsl:element name="c:data">
                            <xsl:attribute name="content-type" select="'application/x-latex'"/>
                            <xsl:apply-imports/>
                        </xsl:element>
                    </xsl:template>
                </xsl:stylesheet>
            </p:inline>
        </p:input>
        <p:with-param name="fontsize" select="$fontsize"/>
        <p:with-param name="font" select="$font"/>
        <p:with-param name="backupFont" select="$backup-font"/>
        <p:with-param name="backupUnicodeRanges" select="$backup-unicode-ranges"/>
        <p:with-param name="defaultLanguage" select="$default-language"/>
        <p:with-param name="stocksize" select="$stocksize"/>
        <p:with-param name="alignment" select="$alignment"/>
        <p:with-param name="pageStyle" select="$page-style"/>
        <p:with-param name="line_spacing" select="$line-spacing"/>
        <p:with-param name="paperwidth" select="$paperwidth"/>
        <p:with-param name="paperheight" select="$paperheight"/>
        <p:with-param name="left_margin" select="$left-margin"/>
        <p:with-param name="right_margin" select="$right-margin"/>
        <p:with-param name="top_margin" select="$top-margin"/>
        <p:with-param name="bottom_margin" select="$bottom-margin"/>
        <p:with-param name="replace_em_with_quote" select="$replace-em-with-quote"/>
        <p:with-param name="endnotes" select="$endnotes"/>
    </p:xslt>
    
    <p:add-attribute match="/*" attribute-name="xml:base" name="latex">
        <p:with-option name="attribute-value"
                       select="//d:file[@media-type='application/x-latex']/resolve-uri(@href, base-uri(.))">
            <p:pipe step="fileset" port="result"/>
        </p:with-option>
    </p:add-attribute>
    
    <!-- TODO: copy images? -->
    
</p:declare-step>
