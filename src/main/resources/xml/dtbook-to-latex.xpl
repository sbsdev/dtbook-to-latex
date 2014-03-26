<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:px="http://www.daisy.org/ns/pipeline/xproc"
    xmlns:sbs="http://www.sbs.ch/pipeline"
    exclude-inline-prefixes="#all"
    type="sbs:dtbook-to-latex" name="dtbook-to-latex" version="1.0">
    
    <p:documentation xmlns="http://www.w3.org/1999/xhtml">
        <h1 px:role="name">DTBook to LaTeX</h1>
        <p px:role="desc">Transforms a DTBook (DAISY 3 XML) document into LaTeX.</p>
        <dl px:role="author">
            <dt>Name:</dt>
            <dd px:role="name">Bert Frees</dd>
            <dt>Organization:</dt>
            <dd px:role="organization" href="http://www.sbs.ch">SBS</dd>
            <dt>E-mail:</dt>
            <dd><a px:role="contact" href="mailto:bert.frees@sbs.ch">bert.frees@sbs.ch</a></dd>
        </dl>
        <p px:role="acknowledgement">The code was taken from the se_tpb_dtbook2latex transformer in DAISY Pipeline 1.</p>
        <p>Original authors:</p>
        <dl px:role="author">
            <dt>Name:</dt>
            <dd px:role="name">Linus Ericson</dd>
            <dt>Organization:</dt>
            <dd px:role="organization" href="http://www.mtm.se">MTM</dd>
        </dl>
        <dl px:role="author">
            <dt>Name:</dt>
            <dd px:role="name">Christian Egli</dd>
            <dt>Organization:</dt>
            <dd px:role="organization" href="http://www.sbs.ch">SBS</dd>
        </dl>
        <dl px:role="author">
            <dt>Name:</dt>
            <dd px:role="name">Bert Frees</dd>
            <dt>Organization:</dt>
            <dd px:role="organization" href="http://www.sbs.ch">SBS</dd>
        </dl>
    </p:documentation>
    
    <p:input port="source" primary="true" px:name="source" px:media-type="application/x-dtbook+xml">
        <p:documentation>
            <h2 px:role="name">source</h2>
            <p px:role="desc">Input DTBook.</p>
        </p:documentation>
    </p:input>
    
    <p:option name="output-dir" required="true" px:output="result" px:type="anyDirURI">
        <p:documentation>
            <h2 px:role="name">output-dir</h2>
            <p px:role="desc">Directory for storing result files.</p>
        </p:documentation>
    </p:option>
    
    <p:import href="dtbook-to-latex.convert.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/dtbook-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl"/>
    
    <!-- =========== -->
    <!-- LOAD DTBOOK -->
    <!-- =========== -->
    
    <px:dtbook-load name="dtbook">
        <p:input port="source">
            <p:pipe step="dtbook-to-latex" port="source"/>
        </p:input>
    </px:dtbook-load>
    
    <!-- ======================= -->
    <!-- CONVERT DTBOOK TO LATEX -->
    <!-- ======================= -->
    
    <sbs:dtbook-to-latex.convert name="latex">
        <p:input port="fileset.in">
            <p:pipe step="dtbook" port="fileset.out"/>
        </p:input>
        <p:input port="in-memory.in">
            <p:pipe step="dtbook" port="in-memory.out"/>
        </p:input>
        <p:with-option name="output-dir" select="$output-dir">
            <p:empty/>
        </p:with-option>
    </sbs:dtbook-to-latex.convert>
    
    <!-- =================== -->
    <!-- STORE LATEX FILESET -->
    <!-- =================== -->
    
    <px:fileset-store>
        <p:input port="fileset.in">
            <p:pipe step="latex" port="fileset.out"/>
        </p:input>
        <p:input port="in-memory.in">
            <p:pipe step="latex" port="in-memory.out"/>
        </p:input>
    </px:fileset-store>
    
</p:declare-step>
