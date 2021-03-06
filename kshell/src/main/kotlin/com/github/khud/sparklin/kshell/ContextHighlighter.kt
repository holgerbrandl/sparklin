package com.github.khud.sparklin.kshell

import sparklin.kshell.org.jline.reader.Highlighter
import sparklin.kshell.org.jline.reader.LineReader
import sparklin.kshell.org.jline.utils.AttributedString
import sparklin.kshell.org.jline.utils.AttributedStringBuilder
import com.github.khud.sparklin.kshell.plugins.BaseHighlighter

class ContextHighlighter(private val isSyntaxMode: (String) -> Boolean,
                         private val findCommand: (String) -> Command?): Highlighter {

    var syntaxHighlighter: BaseHighlighter = DEFAULT

    override fun highlight(reader: LineReader, buffer: String): AttributedString {
        if (isSyntaxMode(buffer)) return syntaxHighlighter.highlight(reader, buffer)
        val highlighter = findCommand(buffer)?.highlighter() ?: DEFAULT
        return highlighter.highlight(reader, buffer)
    }

    companion object {
        private val DEFAULT = object : BaseHighlighter {
            override fun highlight(buffer: String, offset: Int): AttributedString {
                val sb = AttributedStringBuilder()
                sb.append(buffer)
                return sb.toAttributedString()
            }
        }
    }
}