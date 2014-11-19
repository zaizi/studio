/*******************************************************************************
 * Crafter Studio Web-content authoring solution
 *     Copyright (C) 2007-2013 Crafter Software Corporation.
 *
 *     This program is free software: you can redistribute it and/or modify
 *     it under the terms of the GNU General Public License as published by
 *     the Free Software Foundation, either version 3 of the License, or
 *     (at your option) any later version.
 *
 *     This program is distributed in the hope that it will be useful,
 *     but WITHOUT ANY WARRANTY; without even the implied warranty of
 *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *     GNU General Public License for more details.
 *
 *     You should have received a copy of the GNU General Public License
 *     along with this program.  If not, see <http://www.gnu.org/licenses/>.
 ******************************************************************************/
package org.craftercms.cstudio.alfresco.dm.workflow;

import java.util.List;

/**
 * @author Dejan Brkic
 */
public class MultiChannelPublishingContext {

    protected String _publishingChannelGroup;

    protected String _statusMessage;

    protected String _submissionComment;

    public MultiChannelPublishingContext(String publishingChannelGroup, String statusMessage, String submissionComment) {
        this._publishingChannelGroup = publishingChannelGroup;
        this._statusMessage = statusMessage;
        this._submissionComment = submissionComment;
    }

    public String getPublishingChannelGroup() {
        return _publishingChannelGroup;
    }

    public String getStatusMessage() {
        return _statusMessage;
    }

    public String getSubmissionComment() {
        return _submissionComment;
    }
}
