---
created: 2025-06-26T15:30:00 (UTC -05:00)
tags: []
source: https://blog.sqlauthority.com/2017/10/20/sql-server-turn-optimize-ad-hoc-workloads/
author: Pinal Dave
---

# SQL SERVER - When to Turn On Optimize for Ad Hoc Workloads? - SQL Authority with Pinal Dave

> ## Excerpt
> Today, I have very interesting scenario to share with all of you. This is a true story which I encountered in my recent Comprehensive Database Performance Health Check. It is about a very popular SQL Server setting Optimize for Ad Hoc Workloads.

---
Every SQL Server Performance Expert has their own rule. I have a very simple rule. If your adhoc plan cache is 20-30% of total Plan Cache, you should turn on the Optimize for Ad Hoc Workloads. In another scenario it may be not beneficial to you and in very rare scenario, it will degrade your server’s settings.

Here is the script which gives you the size of the AdHoc Plan Cache and Total Plan Cache.

<table border="0" cellpadding="0" cellspacing="0"><tbody><tr><td class="gutter"><div class="line number1 index0 alt2">1</div><div class="line number2 index1 alt1">2</div><div class="line number3 index2 alt2">3</div><div class="line number4 index3 alt1">4</div><div class="line number5 index4 alt2">5</div><div class="line number6 index5 alt1">6</div><div class="line number7 index6 alt2">7</div><div class="line number8 index7 alt1">8</div><div class="line number9 index8 alt2">9</div></td><td class="code"><div class="container"><div class="line number1 index0 alt2"><code class="sql keyword">SELECT</code> <code class="sql plain">AdHoc_Plan_MB, Total_Cache_MB,</code></div><div class="line number2 index1 alt1"><code class="sql spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="sql plain">AdHoc_Plan_MB*100.0 / Total_Cache_MB </code><code class="sql keyword">AS</code> <code class="sql string">'AdHoc %'</code></div><div class="line number3 index2 alt2"><code class="sql keyword">FROM</code> <code class="sql plain">(</code></div><div class="line number4 index3 alt1"><code class="sql keyword">SELECT</code> <code class="sql color2">SUM</code><code class="sql plain">(</code><code class="sql color2">CASE</code></div><div class="line number5 index4 alt2"><code class="sql spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="sql keyword">WHEN</code> <code class="sql plain">objtype = </code><code class="sql string">'adhoc'</code></div><div class="line number6 index5 alt1"><code class="sql spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="sql keyword">THEN</code> <code class="sql plain">size_in_bytes</code></div><div class="line number7 index6 alt2"><code class="sql spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="sql keyword">ELSE</code> <code class="sql plain">0 </code><code class="sql keyword">END</code><code class="sql plain">) / 1048576.0 AdHoc_Plan_MB,</code></div><div class="line number8 index7 alt1"><code class="sql spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="sql color2">SUM</code><code class="sql plain">(size_in_bytes) / 1048576.0 Total_Cache_MB</code></div><div class="line number9 index8 alt2"><code class="sql keyword">FROM</code> <code class="sql plain">sys.dm_exec_cached_plans) T</code></div></div></td></tr></tbody></table>
