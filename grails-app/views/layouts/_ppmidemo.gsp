
<script type="text/ng-template" id="ppmidemo">
<div ng-controller="PPMIDemoController">

<button ng-click="downloadFile()">Download Variant Summary</button>
<div id="ppmi-form">
    <div id="sr-ppmi-variantdb-form">
        <div>
            <button ng-click="fetchVariantDB()" ng-disabled="variantDB.invalid || variantDB.running">Fetch VariantDB Data</button>
        </div>

        <div>
            <label for="variantdb-region" >Regions: </label>
            <input id="variantdb-region" type="text" placeholder="13:10000-12500,15:100-5000" ng-model="variantDB.regions"/>
        </div>

        <div>
            <label for="variantdb-genes">Genes: </label>
            <input id="variantdb-genes" type="text" maxlength="500000" placeholder="ALB,CCR5,CD4,IL10" ng-model="variantDB.selectedGenes"/>
        </div>

        <div>
            <label for="variantdb-server">Server: </label>
            <input id="variantdb-server" type="text" ng-model="variantDB.server"/>
        </div>

        <div id="sr-ppmi-region-form">
            <p>Gene Location:</p>
            <div>
                <input id="sr-ppmi-exonic-check" type="checkbox" ng-model="variantDB.func_refgene.exonic"/>
                <label for="sr-ppmi-exonic-check">exonic</label>
            </div>

            <div>
                <input id="sr-ppmi-intronic-check" type="checkbox" ng-model="variantDB.func_refgene.intronic"/>
                <label for="sr-ppmi-intronic-check">intronic</label>
            </div>

            <div>
                <input id="sr-ppmi-upstream-check" type="checkbox" ng-model="variantDB.func_refgene.upstream"/>
                <label for="sr-ppmi-upstream-check">upstream</label>
            </div>

            <div>
                <input id="sr-ppmi-downstream-check" type="checkbox" ng-model="variantDB.func_refgene.downstream"/>
                <label for="sr-ppmi-downstream-check">downstream</label>
            </div>

            <div>
                <input id="sr-ppmi-splicing-check" type="checkbox" ng-model="variantDB.func_refgene.splicing"/>
                <label for="sr-ppmi-splicing-check">splicing</label>
            </div>

            <div>
                <input id="sr-ppmi-intergenetic-check" type="checkbox" ng-model="variantDB.func_refgene.intergenetic"/>
                <label for="sr-ppmi-intergenetic-check">intergenetic</label>
            </div>
        </div>

        <div id="sr-ppmi-exonic-function-form">
            <p>Exonic Function</p>
            <div>
                <input id="sr-ppmi-synonymous-check" type="checkbox" ng-model="variantDB.exonicfunc_refgene.synonymous_SNV"/>
                <label for="sr-ppmi-synonymous-check">synonymous SNV</label>
            </div>

            <div>
                <input id="sr-ppmi-non-synonymous-check" type="checkbox" ng-model="variantDB.exonicfunc_refgene.nonsynonymous_SNV"/>
                <label for="sr-ppmi-non-synonymous-check">non-synonymous SNV</label>
            </div>

            <div>
                <input id="sr-ppmi-insertion-check1" type="checkbox" ng-model="variantDB.exonicfunc_refgene.frameshift_insertion"/>
                <label for="sr-ppmi-insertion-check1">frameshift insertion</label>
            </div>

            <div>
                <input id="sr-ppmi-insertion-check2" type="checkbox" ng-model="variantDB.exonicfunc_refgene.nonframeshift_insertion"/>
                <label for="sr-ppmi-insertion-check2">nonframeshift insertion</label>
            </div>

            <div>
                <input id="sr-ppmi-deletion-check1" type="checkbox" ng-model="variantDB.exonicfunc_refgene.frameshift_deletion"/>
                <label for="sr-ppmi-deletion-check1">frameshift deletion</label>
            </div>

            <div>
                <input id="sr-ppmi-deletion-check2" type="checkbox" ng-model="variantDB.exonicfunc_refgene.nonframeshift_deletion"/>
                <label for="sr-ppmi-deletion-check2">nonframeshift deletion</label>
            </div>

            <div>
                <input id="sr-ppmi-block-substitution-check1" type="checkbox" ng-model="variantDB.exonicfunc_refgene.frameshift_substitution"/>
                <label for="sr-ppmi-block-substitution-check1">frameshift substitution</label>
            </div>

            <div>
                <input id="sr-ppmi-block-substitution-check2" type="checkbox" ng-model="variantDB.exonicfunc_refgene.nonframeshift_substitution"/>
                <label for="sr-ppmi-block-substitution-check2">nonframeshift substitution</label>
            </div>
        </div>

        <div id="sr-ppmi-maf-form">
            <p>Frequency:</p>
            <div>
                <label for="sr-ppmi-global-maf">MAF (lower than)</label>
                <input id="sr-ppmi-global-maf" type="number" min="0.1" max="1" step="0.05" ng-model="variantDB.misc.globalMAF" style="width: 40px;"/>
            </div>
            <div>
                <label for="sr-ppmi-cohort-maf">Group AF (greater than)</label>
                <input id="sr-ppmi-cohort-maf" type="number" min="0" max="1" step="0.05" ng-model="variantDB.misc.cohortMAF" style="width: 40px;"/>
            </div>
        </div>
    </div>

    <div id="sr-ppmi-pdmap-form">
        <div>
            <button ng-click="createPDMapLayout()" ng-disabled="pdmap.invalid">Create PDMap Overlay</button>
        </div>

        <div>
            <label for="pdmap-user">UserID: </label>
            <input id="pdmap-user" type="text" ng-model="pdmap.user"/>
        </div>

        <div>
            <label for="pdmap-password">Password: </label>
            <input id="pdmap-password" type="password" ng-model="pdmap.password"/>
        </div>

        <div>
            <label for="pdmap-server">Server: </label>
            <input id="pdmap-server" type="text" ng-model="pdmap.server"/>
        </div>
    </div>
</div>
<br/>
<div id="sr-ppmi-messages">
    <p id="error-msgs">{{messages.error}}</p>
    <p id="loading-msgs">Completed Requests: {{messages.finishedRequests}} / {{messages.totalRequests}}</p>
    <table class="sr-ppmi-table">
        <tr>
            <td></td><td>Subset 1</td><td>Subset 2</td>
        </tr>
        <tr>
            <td>#IDs</td><td>{{messages.numTMIDs.subset1}}</td><td>{{messages.numTMIDs.subset2}}</td>
        </tr>
        <tr>
            <td>#IDs with variants</td><td>{{messages.numVIDs.subset1}}</td><td>{{messages.numVIDs.subset2}}</td>
        </tr>
    </table>
</div>
<br/>
<ppmi-demo data="variantDB.data" show="variantDB.showViz" style="float: left;"></ppmi-demo>
</script>
