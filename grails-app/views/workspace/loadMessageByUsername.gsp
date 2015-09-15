<g:each in="${messages}" var="message" status="i">
    <div class="item item-visible <g:if test="${message.sender.id==currentUser.id}">in</g:if>">
        <div class="image">
            <img src="${request.contextPath}/workspace/userAviator?username=${message.sender.username}" alt="${message.sender}">
        </div>
        <div class="text">
            <div class="heading">
                <a href="#">${message.sender}</a>
                <span class="date">${message.dateCreated.format('yyyy-MM-dd HH:mm')}</span>
            </div>
            <p>${message.content}</p>
        </div>
    </div>
</g:each>