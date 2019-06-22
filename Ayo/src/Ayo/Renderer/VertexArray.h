#pragma once

#include "Ayo/Core.h"
#include "Ayo/Renderer/Buffer.h"
#include <memory>

namespace Ayo {

	class AYO_API VertexArray
	{
	public:
		virtual ~VertexArray();

		virtual void Bind() = 0;
		virtual void Unbind() = 0;

		virtual void AddVertexBuffer(const std::shared_ptr<VertexBuffer>& vertexBuffer) = 0;
		virtual void SetIndexBuffer(const std::shared_ptr<IndexBuffer>& vertexBuffer) = 0;

		virtual uint32_t GetVertexArray() const = 0;

		static std::shared_ptr<VertexArray> Create();
	};

}