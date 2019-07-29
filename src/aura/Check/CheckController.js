/**
 * Created by YuriiDyvak on 24.07.2019.
 */

({
    doInit: function (cmp, event, helper) {

        const idCandidate = cmp.get("v.param")
        const idCandidateValue = idCandidate.value
        const idRegexFormat = /[a-zA-Z0-9]{18}|[a-zA-Z0-9]{15}/;
        if (idCandidateValue && idCandidateValue.match(idRegexFormat)) {
            cmp.set("v.isId", true);
        }

    }
});