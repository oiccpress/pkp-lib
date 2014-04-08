{**
 * templates/reviewer/review/reviewFormResponse.tpl
 *
 * Copyright (c) 2014 Simon Fraser University Library
 * Copyright (c) 2003-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Review form response components of review form.
 *}
{iterate from=reviewFormElements item=reviewFormElement}
	{assign var=elementId value=$reviewFormElement->getId()}
	{assign var=value value=$reviewFormResponses.$elementId}

	{if in_array($reviewFormElement->getElementType(), array(REVIEW_FORM_ELEMENT_TYPE_CHECKBOXES, REVIEW_FORM_ELEMENT_TYPE_RADIO_BUTTONS))}
		{assign var=list value=true}
	{else}
		{assign var=list value=false}
	{/if}

	{fbvFormSection translate=false title=$reviewFormElement->getLocalizedQuestion() list=$list}
		{if $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_SMALL_TEXT_FIELD}
			{fbvElement name="reviewFormResponses[$elementId]" type="text" translate=false required=$reviewFormElement->getRequired() id="reviewFormResponses-$elementId" value=$value maxlength="120" inline=true size=$fbvStyles.size.SMALL readonly=$disabled}
		{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_TEXT_FIELD}
			{fbvElement name="reviewFormResponses[$elementId]" type="text" translate=false required=$reviewFormElement->getRequired() id="reviewFormResponses-$elementId" value=$value maxlength="120" readonly=$disabled}
		{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_TEXTAREA}
			{fbvElement name="reviewFormResponses[$elementId]" type="textarea" required=$reviewFormElement->getRequired() id="reviewFormResponses-$elementId" value=$value maxlength="120" readonly=$disabled rows=4 cols=40}
		{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_CHECKBOXES}
			{assign var=possibleResponses value=$reviewFormElement->getLocalizedPossibleResponses()}
			{foreach name=responses from=$possibleResponses key=responseId item=responseItem}
				{if !empty($reviewFormResponses[$elementId]) && in_array($smarty.foreach.responses.iteration, $reviewFormResponses[$elementId])}
					{assign var=checked value=true}
				{else}
					{assign var=checked value=false}
				{/if}
				{assign var=iteration value=$smarty.foreach.responses.iteration}

				{fbvElement type="checkbox" disabled=$disabled name="reviewFormResponses[$elementId][]" id="reviewFormResponses-$elementId-$iteration" value=$iteration checked=$checked label=$responseItem translate=false}
			{/foreach}
		{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_RADIO_BUTTONS}
			{assign var=possibleResponses value=$reviewFormElement->getLocalizedPossibleResponses()}
			{if $iteration == $reviewFormResponses[$elementId]}
				{assign var=checked value=true}
			{else}
				{assign var=checked value=false}
			{/if}
			{foreach name=responses from=$possibleResponses key=responseId item=responseItem}
				{assign var=iteration value=$smarty.foreach.responses.iteration}
				{fbvElement type="radio" disabled=$disabled name="reviewFormResponses[$elementId]" id="reviewFormResponses-$elementId-$iteration" value=$iteration checked=$checked label=$responseItem translate=false}
			{/foreach}
		{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_DROP_DOWN_BOX}
			{fbvElement type="select" subLabelTranslate=false translate=false name="reviewFormResponses[$elementId]" id="reviewFormResponses-$elementId" required=$reviewFormElement->getRequired() readonly=$disabled defaultLabel="" defaultValue="" from=$possibleResponses selected=$reviewFormResponses.$elementId size=$fbvStyles.size.MEDIUM}
		{/if}
	{/fbvFormSection}
{/iterate}
