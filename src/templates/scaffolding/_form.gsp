<%=packageName%>
<% import grails.persistence.Event %>

<div class="row">
 <div class="col-md-12">
<%  excludedProps = Event.allEvents.toList() << 'version' << 'dateCreated' << 'lastUpdated'
persistentPropNames = domainClass.persistentProperties*.name
boolean hasHibernate = pluginManager?.hasGrailsPlugin('hibernate') || pluginManager?.hasGrailsPlugin('hibernate4')
if (hasHibernate) {
    def GrailsDomainBinder = getClass().classLoader.loadClass('org.codehaus.groovy.grails.orm.hibernate.cfg.GrailsDomainBinder')
    if (GrailsDomainBinder.newInstance().getMapping(domainClass)?.identity?.generator == 'assigned') {
        persistentPropNames << domainClass.identifier.name
    }
}
props = domainClass.properties.findAll { persistentPropNames.contains(it.name) && !excludedProps.contains(it.name) && (domainClass.constrainedProperties[it.name] ? domainClass.constrainedProperties[it.name].display : true) }
Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
for (p in props) {
    if (p.embedded) {
        def embeddedPropNames = p.component.persistentProperties*.name
        def embeddedProps = p.component.properties.findAll { embeddedPropNames.contains(it.name) && !excludedProps.contains(it.name) }
        Collections.sort(embeddedProps, comparator.constructors[0].newInstance([p.component] as Object[]))
%><fieldset class="embedded"><legend><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></legend><%
        for (ep in p.component.properties) {
            renderFieldForProperty(ep, p.component, "${p.name}.")
        }
%></fieldset><%
        } else {
            renderFieldForProperty(p, domainClass)
        }
    }

    private renderFieldForProperty(p, owningClass, prefix = "") {
        boolean hasHibernate = pluginManager?.hasGrailsPlugin('hibernate') || pluginManager?.hasGrailsPlugin('hibernate4')
        boolean required = false
        if (hasHibernate) {
            cp = owningClass.constrainedProperties[p.name]
            required = (cp ? !(cp.propertyType in [boolean, Boolean]) && !cp.nullable : false)
        }
%>
    <div class="form-group">
         <label class="col-md-3 control-label"><g:message code="${domainClass.propertyName}.${prefix}${p.name}.label" default="${p.naturalName}" /></label>
         <div class="col-md-9">
             <div class="input-group">
                 <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                 ${renderEditor(p) }
             </div>
             <span class="help-block"><% if (required) { %><span class="required-indicator">*</span><% } %></span>
         </div>
     </div>
<%  } %>

    </div>
</div>

